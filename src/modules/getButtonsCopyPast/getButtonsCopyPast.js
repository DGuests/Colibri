'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { userAttributesPick } = require('@src/utils')
const { obterIdUsuario } = require('../../utils/index')

class GetButtonsCopyPast extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getButtonsCopyPast.js ~ line 8 ~ getButtonsCopyPast ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      const establishment = await dbConnection.model('usuLinkCriado').findAll({
        where: { id_usuario: user.id }
      })

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: getButtonsCopyPast.js ~ line 21 ~ getButtonsCopyPast ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getButtonsCopyPast = new GetButtonsCopyPast()

module.exports = getButtonsCopyPast.main.bind(getButtonsCopyPast)
