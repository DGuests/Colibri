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

      if (points === null) {
        const newLine = {
          id_usuario: user.id,
          reserva_mesa: true,
          cardapio: true,
          cardapio_clicks: 0,
          nome_lista: false,
          nome_lista_clicks: 0,
          comemorar: false,
          espera: false,
          espera_ordem: 0,
          localizacao: false,
          avaliacao: false,
          delivery: false
        }
        const response = await dbConnection.model('usuLink').create(newLine)
        return this.handlerSuccess(response)
      } else {
        return this.handlerSuccess(points)
      }
    } catch (error) {
      console.log('🚀 ~ file: getButtonsLinkBio.js ~ line 16 ~ getButtonsLinkBio ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getButtonsLinkBio = new GetButtonsLinkBio()

module.exports = getButtonsLinkBio.main.bind(getButtonsLinkBio)
