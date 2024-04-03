'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class GetFilteredEventos extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetFilteredEventos.js ~ line 8 ~ GetFilteredEventos ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)

      var whereCondition = {
        eveUsuario: user.id
      }

      const eventos = await dbConnection.model('EveEvento').findOne({
        where: {
          ...whereCondition,
          eveDataEvento: event.pathParameters.id
        }
      })
      console.log(eventos)

      return this.handlerSuccess(eventos)
    } catch (error) {
      console.log('🚀 ~ file: GetFilteredEventos.js ~ line 21 ~ GetFilteredEventos ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getFilteredEventos = new GetFilteredEventos()

module.exports = getFilteredEventos.main.bind(getFilteredEventos)
