'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')
const Sequelize = require('sequelize')

class FindEvents extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: FindEvents.js ~ line 8 ~ FindEvents ~ main ~ event', event)
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

      const eventos = dbConnection.model('EveEvento')
      const giro = dbConnection.model('GiroMesa')
      const lista = dbConnection.model('EveLista')
      const aniversario = dbConnection.model('eveAniversario')
      const colaboradores = dbConnection.model('eveColaborador')

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
            [Sequelize.Op.gte]: hoje
          }
        },
        [['eveDataEvento', 'ASC']],
        null,
        null,
        50
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

      const eventosAnterioresList = await eventos.findAll(query(
        {
          eveUsuario: user.id,
          eveDataEvento: {
            [Sequelize.Op.lte]: new Date()
          }
        },
        [['eveDataEvento', 'DESC']],
        null,
        null,
        20
      ))

      const eventosAnterioresPromise = await Promise.all(
        eventosAnterioresList.map(async (evento) => ({
          ...evento.dataValues,
          GiroMesa: await giro.findAll(query(
            { giroEvento: evento.dataValues.id },
            null,
            null,
            [{ model: dbConnection.model('EveReservaAmbiente') }],
            null
          ))
        }))
      )

      const eventosAnterioresPromiseResolved = []

      for (const evento of eventosAnterioresPromise) {
        const [GiroMesa] = await Promise.all([evento.GiroMesa])

        eventosAnterioresPromiseResolved.push({
          ...evento,
          GiroMesa: GiroMesa ?? []
        })
      }

      return this.handlerSuccess({ eventos: eventosPromiseResolved, eventosAnteriores: eventosAnterioresPromiseResolved })
    } catch (error) {
      console.log('🚀 ~ file: FindEvents.js ~ line 21 ~ FindEvents ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findEvents = new FindEvents()

module.exports = findEvents.main.bind(findEvents)
