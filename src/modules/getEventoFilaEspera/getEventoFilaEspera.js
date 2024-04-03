'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { date } = require('joi')
// const moment = require('moment')
// const { Op } = require('sequelize')
const Sequelize = require('sequelize')

class GetEventoFilaEspera extends BaseHandlerLambda {
  async main (event) {
    console.log(
      '🚀 ~ file: getEventoFilaEspera.js ~ line 10 ~ getEventoFilaEspera ~ main ~ event',
      event
    )
    try {
      const dbConnection = await connection()

      const getIdUser = await dbConnection.model('Users').findOne({
        where: { id: event.pathParameters.id }
      })

      const eventoById = await dbConnection.model('EveEvento').findAll({
        where: {
          eveUsuario: { [Sequelize.Op.eq]: getIdUser.id },
          [Sequelize.Op.and]: [
            {
              eveDataEvento: {
                [Sequelize.Op.lte]: new Date()
              },
              eveDataFimEvento: {
                [Sequelize.Op.gte]: new Date()
              },
              eveEsperaOnline: {
                [Sequelize.Op.eq]: true
              }
            }
          ]
        }
      })
      console.log('GET USERrrrrrrrrrrrrrrrrrrr', eventoById)

      return this.handlerSuccess({ eventos: eventoById, username: getIdUser.slug })
    } catch (error) {
      console.log(
        '🚀 ~ file: getEventoFilaEspera.js ~ line 20 ~ getEventoFilaEspera ~ main ~ error',
        error
      )
      return this.handleError(error)
    }
  }
}

const getEventoFilaEspera = new GetEventoFilaEspera()

module.exports = getEventoFilaEspera.main.bind(getEventoFilaEspera)
