'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')
const Sequelize = require('sequelize')

class FindPastEvents extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file:  FindPastEvents.js ~ line 8 ~  FindPastEvents ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const hoje = new Date()
      hoje.setHours(0, 0, 0, 0)

      const eventos = await dbConnection.model('EveEvento').findAll({
        where: {
          eveUsuario: user.id,
          eveDataEvento: {
            [Sequelize.Op.lte]: new Date()
          }
        },
        limit: 50,
        order: [
          ['eveDataEvento', 'DESC']
        ],
        include: [
          {
            model: dbConnection.model('eveColaborador'),
            attributes: ['id']
          }
        ]
      })

      return this.handlerSuccess(eventos)
    } catch (error) {
      console.log('🚀 ~ file:  FindPastEvents.js ~ line 21 ~  FindPastEvents ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findPastEvents = new FindPastEvents()

module.exports = findPastEvents.main.bind(findPastEvents)
