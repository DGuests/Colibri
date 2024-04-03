'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const sequelize = require('sequelize')

class GetReservaMaxMin extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetReservaMaxMin.js ~ line 8 ~ GetReservaMaxMin ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      if (event.pathParameters.idCenario > 0) {
        const giros = await dbConnection.model('GiroMesa').findAll({
          where: { giroEvento: event.queryStringParameters?.idEvento },
          attributes: ['id']
        })
        console.log("🚀 ~ GetReservaMaxMin ~ giros ~ giros:", giros)

        const reservas = await dbConnection.model('PrmReservaMesa').findAll({
          where: {
            id_evento: event.queryStringParameters?.idEvento,
            reservaAtiva: true
          },
          attributes: ['id', 'reservaMesa', 'reservaHorario']
        })
        console.log("🚀 ~ GetReservaMaxMin ~ reservas ~ reservas:", reservas)

        const mesas = await dbConnection.model('PrmMesa').findAll({
          where: { id_cenario: event.pathParameters.idCenario },
          attributes: ['id']
        })
        console.log("🚀 ~ GetReservaMaxMin ~ mesas ~ mesas:", mesas)

        const minMax = await dbConnection.model('PrmMesa').findAll({
          where: { id_cenario: event.pathParameters.idCenario },
          attributes: [
            [sequelize.fn('min', sequelize.col('n_mes_capacidade_min')), 'minima'],
            [sequelize.fn('max', sequelize.col('n_mes_capacidade_max')), 'maxima']
          ]
        })
        console.log("🚀 ~ GetReservaMaxMin ~ minMax ~ minMax:", minMax)

        let mesasLivres = []
        giros.map(giro => {
          mesas.map(mesa => {
            let mesaLivre = reservas.find(reserva => mesa.id === reserva.reservaMesa && reserva.reservaHorario === giro.id)

            if (mesaLivre === undefined) {
              mesasLivres.push(mesa)
            }
          })
        })

        if (mesasLivres.length > 0) {
          return this.handlerSuccess(minMax)
        } else {
          return this.handlerSuccess({ message: 'Sem reservas disponíveis' })
        }
      } else {
        const giros = await dbConnection.model('GiroMesa').findAll({
          where: { giroEvento: event.queryStringParameters?.idEvento },
          attributes: ['id'],
          include: {
            model: dbConnection.model('EveReservaAmbiente'),
            attributes: ['id', 'limitePessoasReserva', 'limiteReservas', 'minimoPessoasReserva']
          }
        })

        const reservas = await dbConnection.model('PrmReservaMesa').findAll({
          where: {
            id_evento: event.queryStringParameters?.idEvento,
            reservaAtiva: true
          },
          attributes: [
            [sequelize.fn('count', sequelize.col('n_res_qtd_pessoas')), 'QtdTotalReservas']
          ]
        })

        // Verifica se ambiente aceita reservas
        const capacidadeMin = []
        const capacidadeMax = []
        giros.map(giro => {
          giro.EveReservaAmbientes.map(ambiente => {
            if (ambiente.limiteReservas !== null ? (reservas[0].dataValues.QtdTotalReservas < ambiente.limiteReservas) : true) {
              capacidadeMin.push(ambiente.minimoPessoasReserva)
              capacidadeMax.push(ambiente.limitePessoasReserva)
            }
          })
        })

        console.log("🚀 ~ GetReservaMaxMin ~ main ~ capacidadeMin:", capacidadeMin)
        if (capacidadeMax.length > 0 && capacidadeMin.length > 0) {
          const minMax = {
            minima: capacidadeMin.reduce(function (prev, current) { return prev < current ? prev : current }),
            maxima: capacidadeMax.reduce(function (prev, current) { return prev > current ? prev : current })
          }
          return this.handlerSuccess([minMax])
        } else {
          return this.handlerSuccess({ message: 'Sem reservas disponíveis' })
        }
      }
    } catch (error) {
      console.log('🚀 ~ file: GetReservaMaxMin.js ~ line 21 ~ GetReservaMaxMin ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getReservaMaxMin = new GetReservaMaxMin()

module.exports = getReservaMaxMin.main.bind(getReservaMaxMin)
