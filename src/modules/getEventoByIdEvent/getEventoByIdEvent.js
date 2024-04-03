'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const sequelize = require('sequelize')

class GetEventoByIdEvent extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getEventoByIdEvent.js ~ line 10 ~ getEventoByIdEvent ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const eventoById = await dbConnection.model('EveEvento').findOne(
        {
          where: {
            id: event.pathParameters.id
          },
          include: { model: dbConnection.model('EventoEsperaSetores') }
        }
      )
      if (eventoById.eveCenarioMesas > 0) {
        const minMax = await dbConnection.model('PrmMesa').findAll({
          where: { id_cenario: eventoById.eveCenarioMesas },
          attributes: [
            [sequelize.fn('min', sequelize.col('n_mes_capacidade_min')), 'minima'],
            [sequelize.fn('max', sequelize.col('n_mes_capacidade_max')), 'maxima']
          ]
        })
        return this.handlerSuccess({ eventoById, minMax })
      } else {
        const giros = await dbConnection.model('GiroMesa').findAll({
          where: { giroEvento: event.pathParameters.id },
          attributes: ['id'],
          include: {
            model: dbConnection.model('EveReservaAmbiente'),
            attributes: ['id', 'limitePessoasReserva', 'limiteReservas']
          }
        })
        const reservas = await dbConnection.model('PrmReservaMesa').findAll({
          where: {
            id_evento: event.pathParameters.id,
            reservaAtiva: true
          },
          attributes: [
            [sequelize.fn('count', sequelize.col('n_res_qtd_pessoas')), 'QtdTotalReservas']
          ]
        })
        // Verifica se ambiente aceita reservas
        const capacidade = []
        giros.map(giro => {
          giro.EveReservaAmbientes.map(ambiente => {
            if (ambiente.limiteReservas !== null && (reservas[0].dataValues.QtdTotalReservas < ambiente.limiteReservas)) {
              capacidade.push(ambiente.limitePessoasReserva)
            }
          })
        })

        if (capacidade.length > 0) {
          const minMax = {
            minima: capacidade.reduce(function (prev, current) { return prev < current ? prev : current }),
            maxima: capacidade.reduce(function (prev, current) { return prev > current ? prev : current })
          }
          return this.handlerSuccess({ eventoById, minMax })
        } else {
          return this.handlerSuccess({ message: 'Sem reservas disponíveis' })
        }
      }
    } catch (error) {
      console.log('🚀 ~ file: getEventoByIdEvent.js ~ line 20 ~ getEventoByIdEvent ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getEventoByIdEvent = new GetEventoByIdEvent()

module.exports = getEventoByIdEvent.main.bind(getEventoByIdEvent)
