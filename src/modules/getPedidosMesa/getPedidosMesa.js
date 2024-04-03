'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class GetPedidosMesa extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 8 ~ TesteGetButtonsCopyPast ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const pedido = await dbConnection.model('EstFinMesaPedido').findOne({
        where: {
          hash: event.pathParameters.hash,
          mesaStatus: 'active'
        },
        include: [
          { model: dbConnection.model('EstFinMesa') },
          { model: dbConnection.model('estFinPedidosProdutos') }
        ]
      })

      const config = await dbConnection.model('EstFinConfiguracao').findOne({
        where: {
          id_usuario: pedido.usuarioId
        }
      })

      return this.handlerSuccess([pedido, config])
    } catch (error) {
      console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 21 ~ TesteGetButtonsCopyPast ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getPedidosMesa = new GetPedidosMesa()

module.exports = getPedidosMesa.main.bind(getPedidosMesa)
