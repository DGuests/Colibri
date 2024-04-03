'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class GetFuncoesColabFixo extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getFuncoesColabFixo.js ~ line 10 ~ getFuncoesColabFixo ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const ColaboradorFixo = await dbConnection.model('EveFuncaoAcessos').findAll({
        // where: { id_usuario: event.pathParameters.id }
        where: { id_usuario: user.id }
      })
      return this.handlerSuccess(ColaboradorFixo)
      // }
    } catch (error) {
      console.log('🚀 ~ file: getFuncoesColabFixo.js ~ line 20 ~ getFuncoesColabFixo ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getFuncoesColabFixo = new GetFuncoesColabFixo()

module.exports = getFuncoesColabFixo.main.bind(getFuncoesColabFixo)
