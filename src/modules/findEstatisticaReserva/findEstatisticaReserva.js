'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('@src/utils')
const { fn, col, Op } = require('sequelize')
const Sequelize = require('sequelize')

class FindEstatisticaReserva extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: FindEstatisticaReserva.js ~ line 8 ~ FindEstatisticaReserva ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const idUser = obterIdUsuario(event)

      const mes = event.queryStringParameters.mes
      const ano = event.queryStringParameters.ano

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      try {
        const eventosCount = await dbConnection.model('EveEvento').count({
          where: { eveUsuario: user.id }
        })

        const reservasCount = await dbConnection.model('PrmReservaMesa').count({
          where: {
            id_evento: {
              [Op.in]: Sequelize.literal(`(
              SELECT DISTINCT p_eve_id FROM tb_eve_evento
              WHERE f_eve_usuario = ${user.id}
            )`)
            }
          }
        })

        const ultimosEventos = await dbConnection.model('EveEvento').findAll({
          where: { eveUsuario: user.id },
          order: [['eveDataEvento', 'DESC']],
          limit: 15
        })

        const reservasPorEvento = []

        for (const evento of ultimosEventos) {
          const reservasEvento = await dbConnection.model('PrmReservaMesa').count({
            where: {
              id_evento: evento.id,
              reservaAtiva: true
            }
          })
          const reserva = {
            evento: evento.eveDataEvento,
            reservas: reservasEvento
          }
          reservasPorEvento.push(reserva)
        }

        const checkinPorEvento = []

        for (const evento of ultimosEventos) {
          const reservasEvento = await dbConnection.model('PrmReservaMesa').count({
            where: {
              id_evento: evento.id,
              reservaAtiva: true,
              reservaCheckin: {
                [Op.ne]: null
              }
            }
          })
          const reserva = {
            evento: evento.eveDataEvento,
            checkin: reservasEvento
          }
          checkinPorEvento.push(reserva)
        }

        const reservasAtivasCount = await dbConnection.model('PrmReservaMesa').count({
          where: {
            reservaAtiva: true,
            id_evento: {
              [Op.in]: Sequelize.literal(`(
                SELECT DISTINCT p_eve_id FROM tb_eve_evento
                WHERE EXTRACT(MONTH FROM t_eve_data_evento) = ${mes}
                AND EXTRACT(YEAR FROM t_eve_data_evento) = ${ano}
                AND f_eve_usuario = ${user.id}
              )`)
            }
          }
        })

        const reservasCanceladasCount = await dbConnection.model('PrmReservaMesa').count({
          where: {
            reservaAtiva: false,
            id_evento: {
              [Op.in]: Sequelize.literal(`(
                SELECT DISTINCT p_eve_id FROM tb_eve_evento
                WHERE EXTRACT(MONTH FROM t_eve_data_evento) = ${mes}
                AND EXTRACT(YEAR FROM t_eve_data_evento) = ${ano}
                AND f_eve_usuario = ${user.id}
              )`)
            }
          }
        })

        const pessoasPorReservaCount = await dbConnection.model('PrmReservaMesa').findAll({
          attributes: [
            'reservaQtdPessoas',
            [fn('COUNT', col('n_res_qtd_pessoas')), 'qtd']
          ],
          where: {
            id_evento: {
              [Op.in]: Sequelize.literal(`(
                SELECT DISTINCT p_eve_id FROM tb_eve_evento
                WHERE EXTRACT(MONTH FROM t_eve_data_evento) = ${mes}
                AND EXTRACT(YEAR FROM t_eve_data_evento) = ${ano}
                AND f_eve_usuario = ${user.id}
              )`)
            }
          },
          group: ['reservaQtdPessoas']
        })

        const reservasPorHorarioCount = await dbConnection.model('PrmReservaMesa').findAll({
          attributes: [
            'reservaHora',
            [fn('COUNT', col('t_res_hora')), 'qtd']
          ],
          where: {
            id_evento: {
              [Op.in]: Sequelize.literal(`(
                SELECT DISTINCT p_eve_id FROM tb_eve_evento
                WHERE EXTRACT(MONTH FROM t_eve_data_evento) = ${mes}
                AND EXTRACT(YEAR FROM t_eve_data_evento) = ${ano}
                AND f_eve_usuario = ${user.id}
              )`)
            }
          },
          group: ['reservaHora']
        })

        const reservasPeloClienteCount = await dbConnection.model('PrmReservaHistorico').count({
          include: [{
            model: dbConnection.model('PrmReservaMesa'),
            where: {
              id_evento: {
                [Op.in]: Sequelize.literal(`(
                  SELECT DISTINCT p_eve_id FROM tb_eve_evento
                  WHERE EXTRACT(MONTH FROM t_eve_data_evento) = ${mes}
                  AND EXTRACT(YEAR FROM t_eve_data_evento) = ${ano}
                  AND f_eve_usuario = ${user.id}
                )`)
              }
            }
          }],
          where: {
            id_usuario: null
          }
        })

        const reservasPeloEstabelecimentoCount = await dbConnection.model('PrmReservaHistorico').count({
          include: [{
            model: dbConnection.model('PrmReservaMesa'),
            where: {
              id_evento: {
                [Op.in]: Sequelize.literal(`(
                  SELECT DISTINCT p_eve_id FROM tb_eve_evento
                  WHERE EXTRACT(MONTH FROM t_eve_data_evento) = ${mes}
                  AND EXTRACT(YEAR FROM t_eve_data_evento) = ${ano}
                  AND f_eve_usuario = ${user.id}
                )`)
              }
            }
          }],
          where: {
            id_usuario: user.id
          }
        })

        const responseData = {
          eventosCount,
          reservasCount,
          reservasAtivasCount,
          reservasCanceladasCount,
          pessoasPorReservaCount,
          reservasPorHorarioCount,
          reservasPorEvento,
          checkinPorEvento,
          reservasPeloClienteCount,
          reservasPeloEstabelecimentoCount
        }

        return this.handlerSuccess(responseData)
      } catch (error) {
        console.log('🚀 ~ file: findEstatisticaReserva.js:63 ~ FindEstatisticaReserva ~ main ~ error:', error)
        return this.handleError(error)
      }
    } catch (error) {
      console.log('🚀 ~ file: FindEstatisticaReserva.js ~ line 16 ~ FindEstatisticaReserva ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findEstatisticaReserva = new FindEstatisticaReserva()

module.exports = findEstatisticaReserva.main.bind(findEstatisticaReserva)
