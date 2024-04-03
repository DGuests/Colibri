'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetPedidos extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 8 ~ TesteGetButtonsCopyPast ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const mesas = dbConnection.model('EstFinMesa').findAll({
        where: { usuarioId: user.id, status: 'active' },
        attributes: ['id']
      })

      if (mesas.length === 0) {
        return this.handlerSuccess([])
      }

      const establishment = await dbConnection.model('EstFinMesaPedido').findAll({
        where: { usuarioId: user.id, mesaStatus: 'active' },
        attributes: ['id', 'hash', 'mesaValor', 'mesaValorServico', 'mesaValorCouvert', 'mesaValorTotal'],
        include: {
          model: dbConnection.model('estFinPedidosProdutos'),
          attributes: ['id', 'qde', 'produto_nome_original', 'valor_total', 'visivel', 'id_cozinha', 'status', 'createdAt']
        }
      })

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 21 ~ TesteGetButtonsCopyPast ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getPedidos = new GetPedidos()

module.exports = getPedidos.main.bind(getPedidos)
