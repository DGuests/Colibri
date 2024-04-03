'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario, verifyColaborador } = require('../../utils/index')
const Sequelize = require('sequelize')

class FindPastEventsByColab extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file:  .js ~ line 8 ~   FindPastEventsByColab ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const colaborador = await verifyColaborador(user, 'evento')
      console.log('🚀 ~ file:   FindPastEventsByColab.js:60 ~   FindPastEventsByColab ~ main ~ colaborador:', colaborador)

      const hoje = new Date()
      hoje.setHours(0, 0, 0, 0)

      if (event.queryStringParameters === null) {
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
        const eventosPromiseResolved = []
        const eventosAnterioresPromiseResolved = []
        const colaboradorFuncaoEventos = []

        await Promise.all(
          colaborador.map(async (colab) => {
            const eventosList = await eventos.findAll(query(
              {
                id: colab.id_evento,
                eveDataEvento: {
                  [Sequelize.Op.gte]: hoje
                }
              },
              [['eveDataEvento', 'ASC']],
              null,
              null,
              50
            ))

            colaboradorFuncaoEventos.push(colab.EveFuncao.EveFuncaoAcessos[0])

            const eventosPromise = await Promise.all(
              eventosList.map(async (evento) => ({
                ...evento.dataValues,
                GiroMesa: colab.EveFuncao.EveFuncaoAcessos.configuracoes ? await giro.findAll(query(
                  { giroEvento: evento.dataValues.id },
                  null,
                  null,
                  [{ model: dbConnection.model('EveReservaAmbiente') }],
                  null
                )) : null,
                EveLista: colab.EveFuncao.EveFuncaoAcessos.listas ? await lista.findAll(query(
                  { id_evento: evento.dataValues.id },
                  null,
                  ['id', 'dataCheckIn'],
                  null,
                  null
                )) : null,
                eveAniversario: colab.EveFuncao.EveFuncaoAcessos.aniversarios ? await aniversario.findAll(query(
                  { id_evento: evento.dataValues.id },
                  null,
                  ['id'],
                  null,
                  null
                )) : null,
                eveColaborador: colab.EveFuncao.EveFuncaoAcessos.colaboradores ? await colaboradores.findAll(query(
                  { id_evento: evento.dataValues.id },
                  null,
                  ['id'],
                  null,
                  null
                )) : null
              }))
            )

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

            for (const evento of eventosAnterioresPromise) {
              const [GiroMesa] = await Promise.all([evento.GiroMesa])

              eventosAnterioresPromiseResolved.push({
                ...evento,
                GiroMesa: GiroMesa ?? []
              })
            }
          })
        )

        return this.handlerSuccess({ eventos: eventosPromiseResolved, eventosAnteriores: eventosAnterioresPromiseResolved, acessos: colaboradorFuncaoEventos })
      } else if (event.queryStringParameters.datas === '2') {
        let eventos = []
        await Promise.all(
          colaborador.map(async (colab) => {
            eventos = await dbConnection.model('EveEvento').findAll({
              where: {
                id: colab.id_evento,
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
          }))

        return this.handlerSuccess(eventos)
      }
    } catch (error) {
      console.log('🚀 ~ file:   FindPastEventsByColab.js ~ line 21 ~   FindPastEventsByColab ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findPastEventsByColab = new FindPastEventsByColab()

module.exports = findPastEventsByColab.main.bind(findPastEventsByColab)
