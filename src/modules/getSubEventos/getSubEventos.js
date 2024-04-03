'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetSubEventos extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetSubEventos.js ~ line 10 ~ GetSubEventos ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })
      if (!user) {
        throw new Error('user not found!')
      }
      const subeventos = await dbConnection.model('eveAniversario').findAll({
        where: {
          id_evento: event.pathParameters.idEvento
        },
        include: [
          {
            model: dbConnection.model('EveSubEventoTipo')
          }
        ]
      })

      const listasEvento = await dbConnection.model('EveListaTipoEvento').findAll({
        where: {
          id_evento: event.pathParameters.idEvento
        }
      })
      console.log('🚀 ~ file: getSubEventos.js:36 ~ GetSubEventos ~ listasEvento ~ listasEvento:', listasEvento)

      if (listasEvento.length === 0) {
        return this.handlerSuccess({ message: 'Não há listas atribuidas a este evento' })
      }

      const eventos = await dbConnection.model('EveEvento').findAll({
        where: {
          eveUsuario: user.id
        },
        attributes: ['id', 'eveDataEvento'],
        order: [['eveDataEvento', 'DESC']],
        limit: 7
      })

      const evento = await dbConnection.model('EveEvento').findOne({
        where: {
          id: event.pathParameters.idEvento
        },
        attributes: ['evePromoverPadrao']
      })

      const linkPromover = await dbConnection.model('EveLinkPromover').findOne({
        where: {
          id: evento.evePromoverPadrao
        }
      })

      await dbConnection.close()

      return this.handlerSuccess({ subeventos, eventos, linkPromover })
    } catch (error) {
      console.log('🚀 ~ file: GetSubEventos.js ~ line 20 ~ GetSubEventos ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getSubEventos = new GetSubEventos()

module.exports = getSubEventos.main.bind(getSubEventos)
