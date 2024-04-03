'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { Op } = require('sequelize');

class FindEventos extends BaseHandlerLambda {
  async main(event) {
    console.log('🚀 ~ file: FindEventos.js ~ line 10 ~ FindEventos ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const user = await dbConnection.model('Users').findOne({
        where: { slug: event.pathParameters.slug }
      })

      if (!user) {
        return this.handlerSuccess([])
      }

      const eventos = await dbConnection.model('EveEvento').findAll({
        where: {
          eveUsuario: user.id,
          eveDataEvento: {
            [Op.gte]: new Date()
          },
          eveReservaOnline: true,
        },
        // include: [
        //   {
        //     model: dbConnection.model('PrmCenarioMesa'),
        //     attributes: ['id'],
        //     include: {
        //       model: dbConnection.model('ReservaMesaGrupo'),
        //       attributes: ['grupoPreco']
        //     }
        //   }
        // ],
        attributes: ['id', 'eveDataEvento', 'eveTitulo', 'eveDescricao', 'eveCenarioMesas', 'eveReservaPagamento', 'eveReservaPagPessoa'],
        order: [
          ['eveDataEvento', 'ASC']
        ]
      })

      return this.handlerSuccess(eventos)
    } catch (error) {
      console.log('🚀 ~ file: FindEventos.js ~ line 20 ~ FindEventos ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findEventos = new FindEventos()

module.exports = findEventos.main.bind(findEventos)
