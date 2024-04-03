'use strict'
const { randomUUID } = require('crypto')
const { parse } = require('lambda-multipart-parser')
const connection = require('@src/models')
const { BaseHandlerLambda } = require('@src/lib')
const { userAttributesPick } = require('../../utils/index')

const AWS = require('aws-sdk')
AWS.config.update({ region: 'us-west-2' })
const s3 = new AWS.S3({ apiVersion: '2006-03-01' })

class UploadImageEventos extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: U line 8 ~ updatUevent', event)
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
      const key = `flyer/${path}`

      if (event.queryStringParameters?.subevento === 'true') {
        const uploadParams = {
          Bucket: process.env.IMAGE_UPLOAD_BUCKET,
          Key: key,
          Body: Buffer.from(body.foto.replace(/^data:image\/\w+;base64,/, ''), 'base64')
        }

        await s3.upload(uploadParams).promise()

        const url = `https://dg-media.com.br/${key}`

        await dbConnection.model('eveAniversario').update({ flyer: url }, {
          where: {
            id: event.pathParameters.id
          }
        })
        return this.handlerSuccess({ url })
      }

      console.log('KEY', key)

      const uploadParams = {
        Bucket: process.env.IMAGE_UPLOAD_BUCKET,
        Key: key,
        Body: Buffer.from(body.eveFlyer.replace(/^data:image\/\w+;base64,/, ''), 'base64')
      }

      await s3.upload(uploadParams).promise()

      const url = `https://dg-media.com.br/${key}`

      await dbConnection.model('EveEvento').update({ eveFlyer: url }, {
        where: {
          eveUsuario: user.id,
          id: event.pathParameters.id
        }
      })
      return this.handlerSuccess({ url })
    } catch (error) {
      console.log('🚀 ~ file: U line 21 ~ updatUerror', error)
      return this.handleError(error)
    }
  }
}

const uploadImageEventos = new UploadImageEventos()

module.exports = uploadImageEventos.main.bind(uploadImageEventos)
