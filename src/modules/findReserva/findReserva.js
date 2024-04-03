'use strict'

const { BaseHandlerLambda } = require('@src/lib')

const connection = require('@src/models')

class FindReserva extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: findReserva.js:11 ~ FindReserva ~ main ~ event:', event)
    try {
      const dbConnection = await connection()

      const reserva = await dbConnection.model('PrmReservaMesa').findOne({
        where: {
          id: event.pathParameters.id
        },
        attributes: ['id', 'reservaQtdPessoas', 'reservaHora', 'id_evento'],
        include: [{
          model: dbConnection.model('EveEvento'),
          attributes: ['eveDataEvento']
        }]
      })

      return this.handlerSuccess(reserva)
    } catch (error) {
      console.log(
        '🚀 ~ file: FindReserva.js ~ line 38 ~ FindReserva ~ main ~ error',
        error
      )
      return this.handleError(error)
    }
  }
}

const findReserva = new FindReserva()

module.exports = findReserva.main.bind(findReserva)
