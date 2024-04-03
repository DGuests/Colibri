'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetButtonsMidiaLinkBio extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getButtonsMidiaLinkBio.js ~ line 8 ~ getButtonsMidiaLinkBio ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const points = await dbConnection.model('ocEstabelecimento').findOne({
        where: { id_usuario: user.id }
      })

      return this.handlerSuccess(points)
    } catch (error) {
      console.log('🚀 ~ file: getButtonsMidiaLinkBio.js ~ line 16 ~ getButtonsMidiaLinkBio ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getButtonsMidiaLinkBio = new GetButtonsMidiaLinkBio()

module.exports = getButtonsMidiaLinkBio.main.bind(getButtonsMidiaLinkBio)
