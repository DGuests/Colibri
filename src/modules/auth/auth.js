/* eslint-disable camelcase */
'use strict'

const aws = require('aws-sdk')
const axios = require('axios').default
const jwkToPem = require('jwk-to-pem')
const { decode, verify } = require('jsonwebtoken')

const poolData = {
  UserPoolId: process.env.USER_POOL_ID,
  ClientId: process.env.CLIENT_ID
}

// const poolRegion = 'us-east-1'
const poolRegion = 'us-west-2'

const cognitoUrl = `https://cognito-idp.${poolRegion}.amazonaws.com/${poolData.UserPoolId}/.well-known/jwks.json`

const generatePolicy = function (principalId, effect, resource, user) {
  const authResponse = {}

  authResponse.principalId = principalId

  if (effect && resource) {
    const policyDocument = {
      Version: '2012-10-17',
      Statement: []
    }

    const statementOne = {
      Action: 'execute-api:Invoke',
      Effect: effect,
      Resource: resource
    }

    policyDocument.Statement.push(statementOne)

    authResponse.policyDocument = policyDocument
  }

  if (user) {
    const userProps = user
      .UserAttributes
      .map(item => {
        if (item.Name === 'sub') Reflect.set(item, 'Name', 'id')
        return item
      })
      .reduce((acc, { Name, Value }) => Object.assign(acc, { [Name]: Value }), {})

    authResponse.context = {
      username: user.Username,
      ...userProps
    }
  }

  return authResponse
}

const verifyAsync = (token, pem) =>
  new Promise((resolve, reject) => {
    verify(token, pem, (err, result) => {
      if (err) return reject(err)
      return resolve(result)
    })
  })

async function ValidateToken (token) {
  try {
    const { data: body, status: statusCode } = await axios.get(cognitoUrl)

    if (statusCode === 200) {
      const pems = {}
      const keys = body.keys
      for (const i in keys) {
        // Convert each key to PEM
        const key_id = keys[i].kid
        const modulus = keys[i].n
        const exponent = keys[i].e
        const key_type = keys[i].kty
        const jwk = { kty: key_type, n: modulus, e: exponent }
        const pem = jwkToPem(jwk)
        pems[key_id] = pem
      }
      // validate the token
      const decodedJwt = decode(token, { complete: true })

      if (!decodedJwt) {
        throw new Error('Not a valid JWT token')
      }

      const kid = decodedJwt.header.kid
      const pem = pems[kid]
      if (!pem) {
        throw new Error('Invalid pem')
      }
      const payload = await verifyAsync(token, pem)

      if (!payload) {
        throw new Error('Invalid Token.')
      } else {
        return payload
      }
    } else {
      throw new Error('Error! Unable to download JWKs')
    }
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      throw new Error(error.message)
    }
    throw new Error(error.message)
  }
}

module.exports = async function (event, context, callback) {
  console.log('🚀 ~ file: auth.js ~ line 10 ~ event', event)
  try {
    const token = event?.authorizationToken ?? null
    if (!token) {
      throw new Error('invalid token!')
    }
    await ValidateToken(token)

    const params = {
      AccessToken: token
    }

    const cognitoidentityserviceprovider = new aws.CognitoIdentityServiceProvider()

    const user = await cognitoidentityserviceprovider
      .getUser(params)
      .promise()

    return callback(null, generatePolicy('user', 'Allow', event.methodArn, user))
  } catch (error) {
    console.log('🚀 ~ file: auth.js ~ line 27 ~ error', error)
    return callback(error.message)
  }
}
