'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const moment = require('moment')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class GetReservasAmbientes extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getReservasAmbientes.js ~ line 8 ~ getReservasAmbientes ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)
      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const evento = await dbConnection.model('EveReservaAmbiente').findAll({
        where: {
          id_giro: event.pathParameters.idGiro
        }
      })
      return this.handlerSuccess(evento)
      // }
    } catch (error) {
      console.log('🚀 ~ file: getReservasAmbientes.js ~ line 21 ~ getReservasAmbientes ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getReservasAmbientes = new GetReservasAmbientes()

module.exports = getReservasAmbientes.main.bind(getReservasAmbientes)
