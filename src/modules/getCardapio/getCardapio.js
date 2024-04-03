'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetCardapio extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getCardapio.js ~ line 8 ~ getCardapio ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const usuCardapio = await dbConnection.model('UsoCardapio').findOne({
        where: { id_usuario: user.id },
        attributes: ['avaliacao']
      })

      return this.handlerSuccess(usuCardapio)
    } catch (error) {
      console.log('🚀 ~ file: getCardapio.js ~ line 21 ~ getCardapio ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getCardapio = new GetCardapio()

module.exports = getCardapio.main.bind(getCardapio)
