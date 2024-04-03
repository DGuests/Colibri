'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class GetButtonsLinkBioSCognito extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getButtonsLinkBioSCognito.js ~ line 8 ~ getButtonsLinkBioSCognito ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const establishment = await dbConnection.model('usuLink').findOne({
        where: { id_usuario: event.pathParameters.id }
      })

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: getButtonsLinkBioSCognito.js ~ line 16 ~ getButtonsLinkBioSCognito ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getButtonsLinkBioSCognito = new GetButtonsLinkBioSCognito()

module.exports = getButtonsLinkBioSCognito.main.bind(getButtonsLinkBioSCognito)
