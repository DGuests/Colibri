'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { Op } = require('sequelize')
const { obterIdUsuario } = require('../../utils/index')

class GetUser extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getUser.js ~ line 10 ~ GetUser ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const users = await dbConnection.model('Users').findAll({
        where: {
          documento: { [Op.like]: '___________' }
        },
        attributes: ['id', 'nome', 'foto']
      })

      return this.handlerSuccess(users)
    } catch (error) {
      console.log('🚀 ~ file: getUser.js ~ line 20 ~ GetUser ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getUser = new GetUser()

module.exports = getUser.main.bind(getUser)
