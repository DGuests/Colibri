'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class GetVerifyHash extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 8 ~ TesteGetButtonsCopyPast ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      console.log('Dados recebidos: ', event.pathParameters.hash, event?.queryStringParameters)

      const mesaPedido = await dbConnection.model('EstFinMesaPedido').findOne({
        where: {
          token: event?.queryStringParameters?.token,
          mesaStatus: 'active'
        }
      })

      console.log('🚀 ~ file: getVerifyHash.js:21 ~ GetVerifyHash ~ main ~ mesaPedido:', mesaPedido)
      if (!mesaPedido) {
        return this.handlerSuccess(null)
      }

      const mesa = await dbConnection.model('EstFinMesa').findOne({
        where: {
          hash: event.pathParameters.hash,
          status: 'active'
        },
        include: [{
          model: dbConnection.model('EstFinMesaPedido'),
          where: {
            token: event?.queryStringParameters?.token,
            mesaStatus: 'active'
          }
        }]
      })

      return this.handlerSuccess(mesa)
    } catch (error) {
      console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 21 ~ TesteGetButtonsCopyPast ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getVerifyHash = new GetVerifyHash()

module.exports = getVerifyHash.main.bind(getVerifyHash)
