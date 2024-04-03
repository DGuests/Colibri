'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetEvento extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetEvento.js ~ line 10 ~ GetEvento ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const evento = await dbConnection.model('EveEvento').findOne({
        where: {
          id: event.pathParameters.id
        },
        attributes: ['id', 'eveCenarioMesas', 'eveEsperaTolerancia'],
        include: [
          {
            model: dbConnection.model('GiroMesa'),
            attributes: ['id', 'giroEvento', 'giroHoraInicio', 'giroHoraFim', 'giroAtivo'],
            include: [
              { model: dbConnection.model('PrmMesaTravar') },
              { model: dbConnection.model('EveReservaAmbiente') }
            ]
          },
          {
            model: dbConnection.model('eveAniversario'),
            attributes: ['id', 'nome']
          },
          {
            model: dbConnection.model('EventoEsperaSetores'),
            attributes: ['id', 'id_evento', 'titulo', 'ativo']
          }
        ]
      })

      let cenario = {}

      if (evento.eveCenarioMesas !== null) {
        cenario = await dbConnection.model('PrmCenarioMesa').findOne({
          where: {
            id: evento.eveCenarioMesas
          },
          attributes: ['id'],
          include: [
            {
              model: dbConnection.model('PrmMesa'),
              attributes: ['id', 'nome', 'capacidadeMin', 'capacidadeMax', 'numero'],
              include: [
                {
                  model: dbConnection.model('PrmMesaTravar'),
                  attributes: ['id', 'id_horario']
                },
                {
                  model: dbConnection.model('ReservaMesaGrupo'),
                  attributes: ['id', 'grupoTitulo']
                }
              ]
            }
          ],
          order: [[dbConnection.model('PrmMesa'), 'numero', 'ASC']]
        })
      }

      const reservas = await dbConnection.model('PrmReservaMesa').findAll({
        where: {
          id_evento: evento.id
          // reservaAtiva: true
        },
        attributes: ['id', 'id_evento', 'id_usuario', 'nome', 'documento', 'status', 'reservaHorario', 'reservaMesa', 'reservaAtiva', 'reservaQtdPessoas', 'reservaHora', 'reservaEmail', 'reservaCheckin', 'reservaAniversariante', 'reservaAmbiente', 'telefone', 'reservaObs', 'createdAt', 'updatedAt', 'reservaPagamento', 'motivoCancelamento'],
        include: [{
          model: dbConnection.model('PrmReservaHistorico'),
          attributes: ['id', 'id_usuario', 'acao', 'observacao', 'createdAt']
        }]
      })

      const reservasAtivas = reservas.filter(reserva => reserva.reservaAtiva === true)
      const reservasCanceladas = reservas.filter(reserva => reserva.reservaAtiva === false)

      return this.handlerSuccess({ evento, cenario, reservas: reservasAtivas, canceladas: reservasCanceladas })
    } catch (error) {
      console.log('🚀 ~ file: GetEvento.js ~ line 20 ~ GetEvento ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getEvento = new GetEvento()

module.exports = getEvento.main.bind(getEvento)
