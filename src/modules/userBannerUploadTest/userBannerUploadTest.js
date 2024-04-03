// @ts-nocheck
/* eslint-disable camelcase */
'use strict'

const { randomUUID } = require('crypto')
const AWS = require('aws-sdk')
const { parse } = require('lambda-multipart-parser')
const connection = require('@src/models')
const { BaseHandlerLambda } = require('@src/lib')
AWS.config.update({ region: 'us-west-2' })
const { userAttributesPick } = require('@src/utils')

const s3 = new AWS.S3({ apiVersion: '2006-03-01' })

class UserBannerUploadTest extends BaseHandlerLambda {
  async main (event) {
    // console.log('EVENT', event)
    try {
      const dbConnection = await connection()

      const authorizerContext = event?.requestContext?.authorizer ?? null

      const userContext = userAttributesPick(authorizerContext)

      if (!userContext) {
        throw new Error('user not found!')
      }

      const user = await dbConnection.model('Users').findOne({
        where: {
          idCognito: userContext.id
        },
        attributes: ['id']
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const body = await parse(event)

      const path = `${randomUUID()}.png`
      const key = `banners/${path}`

      const uploadParams = {
        Bucket: process.env.IMAGE_UPLOAD_BUCKET,
        Key: key,
        Body: Buffer.from(body.image.replace(/^data:image\/\w+;base64,/, ''), 'base64')
      }

      await s3.upload(uploadParams).promise()
      const url = `https://dg-media.com.br/${key}`

      await dbConnection.model('Users').update({ banner: path }, {
        where: { id: user.id }
      })

      return this.handlerSuccess({ url })
    } catch (error) {
      console.log('🚀 ~ file: userBannerUploadTest.js ~ line 35 ~ userBannerUploadTest ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const userBannerUploadTest = new UserBannerUploadTest()

module.exports = userBannerUploadTest.main.bind(userBannerUploadTest)
