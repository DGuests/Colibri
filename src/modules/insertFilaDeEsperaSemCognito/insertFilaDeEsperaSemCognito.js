'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class InsertFilaDeEsperaSemCognito extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: insertFilaDeEsperaSemCognito.js ~ line 8 ~ insertFilaDeEsperaSemCognito ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)
      // const evento = await dbConnection.model('EveEvento').findOne({
      //   where: { id: event.pathParameters.id },
      //   // attributes: ['eveEsperaOnline']
      // })

      const mesaEspera = await dbConnection.model('PrmMesaEspera').create(data)
      return this.handlerSuccess(mesaEspera)

      // console.log('EVENTO', evento.dataValues.eveEsperaOnline)
    } catch (error) {
      console.log('🚀 ~ file: insertFilaDeEsperaSemCognito.js ~ line 21 ~ insertFilaDeEsperaSemCognito ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertFilaDeEsperaSemCognito = new InsertFilaDeEsperaSemCognito()

module.exports = insertFilaDeEsperaSemCognito.main.bind(insertFilaDeEsperaSemCognito)
