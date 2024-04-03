'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class GetGiroReserva extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetGiroReserva.js ~ line 8 ~ GetGiroReserva ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const eventos2 = await dbConnection.model('GiroMesa').findAll({
        where: {
          giroEvento: event.pathParameters.idEvento
        },
        include: [
          {
            model: dbConnection.model('EveEvento'),
            include: [
              {
                model: dbConnection.model('PrmCenarioMesa'),
                attributes: ['id'],
                // required: false,
                include: [
                  { model: dbConnection.model('ReservaMesaGrupo') },
                  {
                    model: dbConnection.model('PrmMesa'),
                    // required: false,
                    // attributes: ['id', 'capacidadeMin', 'capacidadeMax'],
                    include: [
                      { model: dbConnection.model('PrmMesaTravar') },
                      {
                        model: dbConnection.model('PrmReservaMesa')
                      }
                    ]
                  }
                ]
              }
            ]
          }]
      })

      return this.handlerSuccess(eventos2)
    } catch (error) {
      console.log('🚀 ~ file: GetGiroReserva.js ~ line 21 ~ GetGiroReserva ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getGiroReserva = new GetGiroReserva()

module.exports = getGiroReserva.main.bind(getGiroReserva)
