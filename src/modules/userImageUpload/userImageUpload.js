// @ts-nocheck
/* eslint-disable camelcase */
'use strict'

const { randomUUID } = require('crypto')
const AWS = require('aws-sdk')
const { parse } = require('lambda-multipart-parser')
const connection = require('@src/models')
const { userAttributesPick } = require('@src/utils')
const { obterIdUsuario } = require('../../utils/index')

const { BaseHandlerLambda } = require('@src/lib')

// AWS.config.update({ region: 'us-east-1' })
AWS.config.update({ region: 'us-west-2' })

const s3 = new AWS.S3({ apiVersion: '2006-03-01' })

class UserImageUpload extends BaseHandlerLambda {
  async main (event) {
    try {
      const body = await parse(event)

      const key = `users-profiles/${randomUUID()}.${body.files[0].contentType.split('/')[1]}`

      await s3
        .putObject({
          Body: body.files[0].content,
          Key: key,
          ContentType: body.files[0].contentType,
          Bucket: process.env.IMAGE_UPLOAD_BUCKET,
          ACL: 'public-read'
        })
        .promise()

      const url = `https://${process.env.IMAGE_UPLOAD_BUCKET}.s3.amazonaws.com/${key}`

      // const authorizerContext = event?.requestContext?.authorizer ?? null

      // const userContext = userAttributesPick(authorizerContext)

      const dbConnection = await connection()
      let idUser = obterIdUsuario(event)

      await dbConnection.model('Users').update(
        {
          profile_url: url
        },
        {
          where: { id: idUser }
        }
      )

      return this.handlerSuccess({ url })
    } catch (error) {
      console.log('🚀 ~ file: userImageUpload.js ~ line 35 ~ UserImageUpload ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const userImageUpload = new UserImageUpload()

module.exports = userImageUpload.main.bind(userImageUpload)
