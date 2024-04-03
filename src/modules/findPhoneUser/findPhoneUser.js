'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class FindPhoneUser extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: FindPhoneUser.js ~ line 10 ~ FindPhoneUser ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const phone = await dbConnection.model('PrmReservaMesa').findOne({
        where: {
          telefone: event.pathParameters.phone
        },
        attributes: ['nome', 'reservaEmail', 'documento']
      })

      return this.handlerSuccess(phone)
    } catch (error) {
      console.log('🚀 ~ file: FindPhoneUser.js ~ line 20 ~ FindPhoneUser ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findPhoneUser = new FindPhoneUser()

module.exports = findPhoneUser.main.bind(findPhoneUser)
