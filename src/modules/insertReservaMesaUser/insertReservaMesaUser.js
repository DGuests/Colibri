'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { Op } = require('sequelize')
const sequelize = require('sequelize')

class InsertReservaMesaUser extends BaseHandlerLambda {
  async main(event) {
    console.log('🚀 ~ file: InsertReservaMesaUser.js ~ line 8 ~ InsertReservaMesaUser ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const data = this.parseEvent(event)

      const user = await dbConnection.model('Users').findOne({
        where: { slug: data.id_usuario }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const evento = await dbConnection.model('EveEvento').findOne({
        where: { id: data.id_evento },
        attributes: ['id', 'eveDataEvento']
      })

      const mesasLivres = []
      let passouNaTrava = false

      if (data.reservaAmbiente === null) {
        const mesas = await dbConnection.model('PrmMesa').findAll({
          where: {
            id_cenario: data.idCenarioMesa,
            capacidadeMin: { [Op.lte]: Number(data.reservaQtdPessoas) },
            capacidadeMax: { [Op.gte]: Number(data.reservaQtdPessoas) }
          },
          attributes: ['id', 'id_grupo', 'capacidadeMin', 'capacidadeMax']
        })

        const reservas = await dbConnection.model('PrmReservaMesa').findAll({
          where: {
            id_evento: data.id_evento,
            reservaAtiva: true
          },
          attributes: ['reservaMesa', 'reservaHorario', 'reservaAmbiente', 'reservaQtdPessoas']
        })

        mesas.map(mesa => {
          const achouReserva = reservas.find(reserva => reserva.reservaMesa === mesa.id && reserva.reservaHorario === data.reservaHorario)
          if (achouReserva === undefined && data.id_grupo > 0) {
            if (mesa.id_grupo === data.id_grupo) {
              mesasLivres.push(mesa)
            }
          } else if (achouReserva === undefined && data.id_grupo === null) {
            mesasLivres.push(mesa)
          }
        })

      } else {
        const ambiente = await dbConnection.model('EveReservaAmbiente').findOne({
          where: { id: data.reservaAmbiente.id }
        })
        console.log("🚀 ~ InsertReservaMesaUser ~ ambiente ~ ambiente:", ambiente)
        const reservasTrava = await dbConnection.model('PrmReservaMesa').findAll({
          where: {
            reservaAmbiente: data.reservaAmbiente,
            id_evento: data.id_evento
          },
          attributes: [
            [sequelize.fn('count', sequelize.col('n_res_qtd_pessoas')), 'QtdTotalReservas'],
            [sequelize.fn('sum', sequelize.col('n_res_qtd_pessoas')), 'QtdTotalPessoas']
          ]
        })

        if (
          (ambiente.limitePessoasReserva !== null ? (data.reservaQtdPessoas <= ambiente.limitePessoasReserva) : true) &&
          (ambiente.limiteReservas !== null ? (reservasTrava[0].dataValues.QtdTotalReservas < ambiente.limiteReservas) : true) &&
          (ambiente.limitePessoas !== null ? ((Number(reservasTrava[0].dataValues.QtdTotalPessoas) + data.reservaQtdPessoas) <= ambiente.limitePessoas) : true)
        ) {
          passouNaTrava = true
        } else {
          throw new Error('Não passou na trava')
        }
      }

      const reservaObj = {
        id_evento: data.id_evento,
        reservaHora: data.reservaHora,
        reservaHorario: data.reservaHorario,
        nome: data.nome,
        reservaMesa: data.reservaAmbiente === null ? mesasLivres[0]?.id : null,
        reservaAmbiente: data.reservaAmbiente,
        reservaQtdPessoas: data.reservaQtdPessoas,
        reservaPagamento: data.reservaPagamento ?? null,
      }

      console.log("🚀 ~ InsertReservaMesaUser ~ main ~ mesasLivres:", mesasLivres)

      if (data.reservaAmbiente !== null && passouNaTrava === true) {
        const mesaEspera = await dbConnection.model('PrmReservaMesa').create(reservaObj)
        await dbConnection.model('EveLista').create({
          id_evento: data.id_evento,
          nome: data.nome,
          email: data.reservaEmail,
          dataNascimento: data.dataNascimento,
          documento: data.cpf,
          telefone: data.telefone
        })


        let objResponse = {
          nome: data.nome,
          email: data.reservaEmail,
          localizacao: user.endereco,
          data: evento.eveDataEvento,
          horario: data.reservaHora,
          qtdPessoas: data.reservaQtdPessoas,
        }
        return this.handlerSuccess(objResponse)
      } else if (data.reservaAmbiente === null && mesasLivres.length > 0) {
        const mesaEspera = await dbConnection.model('PrmReservaMesa').create(reservaObj)

        await dbConnection.model('EveLista').create({
          id_evento: data.id_evento,
          nome: data.nome,
          email: data.reservaEmail,
          dataNascimento: data.dataNascimento,
          documento: data.cpf,
          telefone: data.telefone
        })
        let objResponse = {
          nome: data.nome,
          email: data.reservaEmail,
          localizacao: user.nome,
          data: evento.eveDataEvento,
          horario: data.reservaHora,
          qtdPessoas: data.reservaQtdPessoas,
        }
        return this.handlerSuccess(objResponse)
      } else {
        console.log('Else: ', reservaObj)
        return this.handleError({ message: 'Não há mesas disponíveis' })
      }

    } catch (error) {
      console.log('🚀 ~ file: InsertReservaMesaUser.js ~ line 21 ~ InsertReservaMesaUser ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertReservaMesaUser = new InsertReservaMesaUser()

module.exports = insertReservaMesaUser.main.bind(insertReservaMesaUser)
