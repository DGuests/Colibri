'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')
class GetMesas extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetMesas.js ~ line 8 ~ GetMesas ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)
      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      // const authorizerContext = event?.requestContext?.authorizer ?? null
      // const verifyAccess = await verifyData('User', authorizerContext)

      // if (idUser !== undefined || idUser !== null) {
      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)

      const mesas = await dbConnection.model('PrmMesa').findAll({
        where: {
          id_usuario: user.id,
          id_cenario: event.queryStringParameters.id
        },
        include: [
          { model: dbConnection.model('ReservaMesaGrupo') },
          { model: dbConnection.model('PrmCenarioMesa') },
          { model: dbConnection.model('PrmMesaTravar') }
        ]
      })

      return this.handlerSuccess(mesas)
      // }
    } catch (error) {
      console.log('🚀 ~ file: GetMesas.js ~ line 21 ~ GetMesas ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getMesas = new GetMesas()

module.exports = getMesas.main.bind(getMesas)
