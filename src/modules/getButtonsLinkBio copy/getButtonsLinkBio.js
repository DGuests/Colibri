'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetButtonsLinkBio extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getButtonsLinkBio.js ~ line 8 ~ getButtonsLinkBio ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const points = await dbConnection.model('usuLink').findOne({
        where: { id_usuario: user.id }
      })

      return this.handlerSuccess(points)
    } catch (error) {
      console.log('🚀 ~ file: getButtonsLinkBio.js ~ line 16 ~ getButtonsLinkBio ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getButtonsLinkBio = new GetButtonsLinkBio()

module.exports = getButtonsLinkBio.main.bind(getButtonsLinkBio)
