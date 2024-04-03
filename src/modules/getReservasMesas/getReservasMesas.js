'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('@src/utils')

class GetReservasMesas extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetReservasMesas.js ~ line 10 ~ GetReservasMesas ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const reserva = await dbConnection.model('PrmReservaMesa').findAll({
        where: {
          id_evento: event.pathParameters.idEvento
        },
        attributes: ['nome', 'telefone']
      })
      return this.handlerSuccess(reserva)
    } catch (error) {
      console.log('🚀 ~ file: GetReservasMesas.js ~ line 20 ~ GetReservasMesas ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getReservasMesas = new GetReservasMesas()

module.exports = getReservasMesas.main.bind(getReservasMesas)
