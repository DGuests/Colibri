'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const moment = require('moment')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class InsertReservaAmbiente extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: insertReservaAmbiente.js ~ line 8 ~ insertReservaAmbiente ~ main ~ event', event)
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

      const evento = await dbConnection.model('EveReservaAmbiente').bulkCreate(data)
      return this.handlerSuccess(evento)
      // }
    } catch (error) {
      console.log('🚀 ~ file: insertReservaAmbiente.js ~ line 21 ~ insertReservaAmbiente ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertReservaAmbiente = new InsertReservaAmbiente()

module.exports = insertReservaAmbiente.main.bind(insertReservaAmbiente)
