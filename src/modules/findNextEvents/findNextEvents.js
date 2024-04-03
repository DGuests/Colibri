'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')
const Sequelize = require('sequelize')
const moment = require('moment-timezone')

class FindNextEvents extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file:  FindNextEvents.js ~ line 8 ~  FindNextEvents ~ main ~ event', event)
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

      // MAIS EVENTOS
      const eventos = dbConnection.model('EveEvento')
      const giro = dbConnection.model('GiroMesa')
      const lista = dbConnection.model('EveLista')
      const aniversario = dbConnection.model('eveAniversario')
      const colaboradores = dbConnection.model('eveColaborador')

      console.log('Data: ', moment(event.queryStringParameters.startDate, 'YYYY-MM-DD').format('YYYY-MM-DD HH:mm:ss'))

      const query = (where, order, attributes, include, limit) => ({
        where: where,
        order: order,
        attributes: attributes,
        include: include,
        limit: limit
      })

      const eventosList = await eventos.findAll(query(
        {
          eveUsuario: user.id,
          eveDataEvento: {
            [Sequelize.Op.gte]: moment(event.queryStringParameters.startDate, 'YYYY-MM-DD').add(1, 'day').format('YYYY-MM-DD HH:mm:ss')
            // [Sequelize.Op.gte]: '2021-01-01 00:00:00'
          }
        },
        [['eveDataEvento', 'ASC']],
        null,
        null,
        20
      ))

      const eventosPromise = await Promise.all(
        eventosList.map(async (evento) => ({
          ...evento.dataValues,
          GiroMesa: await giro.findAll(query(
            { giroEvento: evento.dataValues.id },
            null,
            null,
            [{ model: dbConnection.model('EveReservaAmbiente') }],
            null
          )),
          EveLista: await lista.findAll(query(
            { id_evento: evento.dataValues.id },
            null,
            ['id', 'dataCheckIn'],
            null,
            null
          )),
          eveAniversario: await aniversario.findAll(query(
            { id_evento: evento.dataValues.id },
            null,
            ['id'],
            null,
            null
          )),
          eveColaborador: await colaboradores.findAll(query(
            { id_evento: evento.dataValues.id },
            null,
            ['id'],
            null,
            null
          ))
        }))
      )

      const eventosPromiseResolved = []

      for (const evento of eventosPromise) {
        const [GiroMesa, EveLista, eveAniversario, eveColaborador] = await Promise.all([evento.GiroMesa, evento.EveLista, evento.eveAniversario, evento.eveColaborador])

        eventosPromiseResolved.push({
          ...evento,
          GiroMesa: GiroMesa ?? [],
          EveLista: EveLista ?? [],
          eveAniversario: eveAniversario ?? [],
          eveColaborador: eveColaborador ?? []
        })
      }

      return this.handlerSuccess({ eventos: eventosPromiseResolved })
    } catch (error) {
      console.log('🚀 ~ file:  FindNextEvents.js ~ line 21 ~  FindNextEvents ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findNextEvents = new FindNextEvents()

module.exports = findNextEvents.main.bind(findNextEvents)
