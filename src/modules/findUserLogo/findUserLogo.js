'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class FindUserLogo extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: findUserLogo.js ~ line 10 ~ findUserLogo ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const users = await dbConnection.model('UsuLogo').findAll({
        where: {
          logoUsuario: user.id
        }
      })

      return this.handlerSuccess(users)
    } catch (error) {
      console.log('🚀 ~ file: findUserLogo.js ~ line 20 ~ findUserLogo ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findUserLogo = new FindUserLogo()

module.exports = findUserLogo.main.bind(findUserLogo)
