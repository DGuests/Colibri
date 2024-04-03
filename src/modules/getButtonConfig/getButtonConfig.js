'use strict'

const { BaseHandlerLambda } = require('@src/lib')
// const { validationRegisterBlacklist } = require('@src/utils/validator')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetButtonConfig extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetButtonConfig.js ~ line 8 ~ GetButtonConfig ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      // const data = this.parseEvent(event)
      const idUser = obterIdUsuario(event)
      console.log('Dados recebidos: ', event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const config = await dbConnection.model('EstFinConfiguracao').findOne({
        where: { id_usuario: user.id }
      })

      if (config === null) {
        const configCreate = await dbConnection.model('EstFinConfiguracao').create({
          id_usuario: user.id,
          couvert: 0,
          valoresPedido: false,
          taxaServico: 0,
          exigirDados: false,
          exigirToken: false
        })
        return this.handlerSuccess(configCreate)
      }

      return this.handlerSuccess(config)
    } catch (error) {
      console.log('🚀 ~ file: GetButtonConfig.js ~ line 21 ~ GetButtonConfig ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getButtonConfig = new GetButtonConfig()

module.exports = getButtonConfig.main.bind(getButtonConfig)
