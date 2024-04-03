'use strict'
const { randomUUID } = require('crypto')
const { parse } = require('lambda-multipart-parser')
const connection = require('@src/models')
const { userAttributesPick } = require('../../utils/index')
const { BaseHandlerLambda } = require('@src/lib')

const AWS = require('aws-sdk')
AWS.config.update({ region: 'us-west-2' })
const s3 = new AWS.S3({ apiVersion: '2006-03-01' })

class UploadImageProduct extends BaseHandlerLambda {
  async main (event) {
    console.log('EVENT', event)
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

      const key = 'cardapio/'
      const path = `${randomUUID()}.png`
      const url = `${key}${path}`

      const uploadParams = {
        Bucket: process.env.IMAGE_UPLOAD_BUCKET,
        Key: url,
        Body: Buffer.from(body.image.replace(/^data:image\/\w+;base64,/, ''), 'base64')
      }

      await s3.upload(uploadParams).promise()

      return this.handlerSuccess(path)
    } catch (error) {
      console.log('🚀 ~ file: productImageUploadTest.js ~ line 35 ~ productImageUploadTest ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const uploadImageProduct = new UploadImageProduct()

module.exports = uploadImageProduct.main.bind(uploadImageProduct)
