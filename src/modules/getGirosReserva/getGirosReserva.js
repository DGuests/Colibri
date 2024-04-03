'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { Op } = require('sequelize')

class GetGirosReserva extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetGirosReserva.js ~ line 8 ~ GetGirosReserva ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const giros = await dbConnection.model('GiroMesa').findAll({
        where: { giroEvento: event.queryStringParameters?.idEvento },
        attributes: ['id', 'giroHoraInicio', 'giroHoraFim'],
        // eslint-disable-next-line quotes
        include: (event.queryStringParameters?.idCenario === "null") ? {
          model: dbConnection.model('EveReservaAmbiente'),
          where: {
            limitePessoasReserva: { [Op.gte]: event.queryStringParameters?.qtd }
          },
          attributes: ['id', 'id_giro', 'nome', 'limiteReservas', 'limitePessoas', 'limitePessoasReserva']
        } : null
      })

      const mesas = await dbConnection.model('PrmMesa').findAll({
        where: {
          id_cenario: event.queryStringParameters.idCenario,
          capacidadeMin: { [Op.lte]: Number(event.queryStringParameters.qtd) },
          capacidadeMax: { [Op.gte]: Number(event.queryStringParameters.qtd) }
        },
        attributes: ['id', 'id_grupo', 'capacidadeMin', 'capacidadeMax']
      })

      const reservas = await dbConnection.model('PrmReservaMesa').findAll({
        where: {
          id_evento: event.queryStringParameters?.idEvento,
          reservaAtiva: true
        },
        attributes: ['reservaMesa', 'reservaHorario', 'reservaAmbiente', 'reservaQtdPessoas']
      })

      const grupos = await dbConnection.model('ReservaMesaGrupo').findAll({
        where: { grupoCenario: event.queryStringParameters.idCenario },
        attributes: ['id', 'grupoTitulo']
      })

      return this.handlerSuccess({ giros, mesas, reservas, grupos })
    } catch (error) {
      console.log('🚀 ~ file: GetGirosReserva.js ~ line 21 ~ GetGirosReserva ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getGirosReserva = new GetGirosReserva()

module.exports = getGirosReserva.main.bind(getGirosReserva)
