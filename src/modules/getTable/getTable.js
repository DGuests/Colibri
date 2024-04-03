'use strict'

const { BaseHandlerLambda } = require('@src/lib')
// const { validationRegisterBlacklist } = require('@src/utils/validator')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class GetTable extends BaseHandlerLambda {
  async main(event) {
    console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 8 ~ TesteGetButtonsCopyPast ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const establishment = await dbConnection.model('EstFinMesa').findAll({
        where: { usuarioId: user.id },
        include: [{
          model: dbConnection.model('EstFinMesaPedido'),
          include: { model: dbConnection.model('estFinPedidosProdutos') },
          // limit: 1,
          order: [['id', 'DESC']],
        }]
      })

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: TesteGetButtonsCopyPast.js ~ line 21 ~ TesteGetButtonsCopyPast ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getTable = new GetTable()

module.exports = getTable.main.bind(getTable)
