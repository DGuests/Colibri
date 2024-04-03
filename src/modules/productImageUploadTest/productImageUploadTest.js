// @ts-nocheck
'use strict'
const { randomUUID } = require('crypto')
const { parse } = require('lambda-multipart-parser')
const connection = require('@src/models')
const { userAttributesPick } = require('../../utils/index')
const { BaseHandlerLambda } = require('@src/lib')

const AWS = require('aws-sdk')
AWS.config.update({ region: 'us-west-2' })
const s3 = new AWS.S3({ apiVersion: '2006-03-01' })

class ProductImageUploadTest extends BaseHandlerLambda {
  async mainm (event) {
    console.log('EVENT', event)
    try {
      const { id } = event.pathParameters
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

      if (!user || !id > 0) {
        throw new Error('user not found!')
      }

      const body = await parse(event)

      const path = `${randomUUID()}.png`
      const key = `cardapio/${path}`

      console.log('KEY', key)

      const uploadParams = {
        Bucket: process.env.IMAGE_UPLOAD_BUCKET,
        Key: key,
        Body: Buffer.from(body.image.replace(/^data:image\/\w+;base64,/, ''), 'base64')
      }

      await s3.upload(uploadParams).promise()

      const url = `https://dg-media.com.br/${key}`

      const produto = await dbConnection.model('estFinProdutos').update({ foto: url }, {
        where: {
          id: event.pathParameters.id
        }
      })

      return this.handlerSuccess(produto)
    } catch (error) {
      console.log('🚀 ~ file: productImageUploadTest.js ~ line 35 ~ productImageUploadTest ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const productImageUploadTest = new ProductImageUploadTest()

module.exports = productImageUploadTest.main.bind(productImageUploadTest)
