'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetButtonsCopyPastLinkBio extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getButtonsCopyPastLinkBio.js ~ line 8 ~ getButtonsCopyPastLinkBio ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const establishment = await dbConnection.model('usuLinkCriado').findAll({
        where: { id_usuario: user.id },
        attributes: ['id', 'texto', 'url', 'ordem', 'is_ativo', 'clicks']
      })

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: getButtonsCopyPastLinkBio.js ~ line 21 ~ getButtonsCopyPastLinkBio ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getButtonsCopyPastLinkBio = new GetButtonsCopyPastLinkBio()

module.exports = getButtonsCopyPastLinkBio.main.bind(getButtonsCopyPastLinkBio)
