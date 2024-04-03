'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { Op } = require('sequelize')

class GetAllEventosUser extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetAllEventosUser.js ~ line 8 ~ GetAllEventosUser ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const user = await dbConnection.model('Users').findOne({
        where: { slug: event.pathParameters.idEstabelecimento }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const eventosDatas = await dbConnection.model('EveEvento').findAll({
        where: {
          eveUsuario: user.id,
          eveReservaOnline: true,
          eveDataEvento: {
            [Op.gte]: new Date()
          }
        },
        attributes: ['id', 'eveDataEvento', 'eveCenarioMesas', 'eveReservaPagamento', 'eveReservaPagPessoa'],
        // include: [
        //   {
        //     model: dbConnection.model('GiroMesa'),
        //     attributes: ['id', 'giroHoraInicio', 'giroHoraFim'],
        //     include: {
        //       model: dbConnection.model('EveReservaAmbiente'),
        //       attributes: ['id', 'id_giro', 'nome', 'limiteReservas', 'limitePessoas', 'limitePessoasReserva']
        //     }
        //   },
        //   {
        //     model: dbConnection.model('PrmReservaMesa'),
        //     attributes: ['id', 'reservaMesa', 'reservaHorario', 'reservaAmbiente', 'reservaAtiva', 'reservaQtdPessoas']
        //   },
        //   {
        //     model: dbConnection.model('PrmCenarioMesa'),
        //     attributes: ['id', 'nome'],
        //     include: [
        //       {
        //         model: dbConnection.model('PrmMesa'),
        //         attributes: ['id', 'id_grupo', 'capacidadeMin', 'capacidadeMax']
        //       },
        //       {
        //         model: dbConnection.model('ReservaMesaGrupo'),
        //         attributes: ['id', 'grupoTitulo']
        //       }
        //     ]
        //   }
        // ],
        order: [
          ['eveDataEvento', 'ASC']
        ]
      })

      return this.handlerSuccess(eventosDatas)
    } catch (error) {
      console.log('🚀 ~ file: GetAllEventosUser.js ~ line 21 ~ GetAllEventosUser ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getAllEventosUser = new GetAllEventosUser()

module.exports = getAllEventosUser.main.bind(getAllEventosUser)
