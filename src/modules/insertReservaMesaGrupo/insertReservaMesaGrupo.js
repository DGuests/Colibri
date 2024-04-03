'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class InsertReservaMesaGrupo extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertReservaMesaGrupo.js ~ line 8 ~ InsertReservaMesaGrupo ~ main ~ event', event)
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
      // const authorizerContext = event?.requestContext?.authorizer ?? null
      // const verifyAccess = await verifyData('User', authorizerContext)

      // if (idUser !== undefined || idUser !== null) {
      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)

      const mesaGrupo = await dbConnection.model('ReservaMesaGrupo').create(data)

      return this.handlerSuccess(mesaGrupo)
      // }
    } catch (error) {
      console.log('🚀 ~ file: InsertReservaMesaGrupo.js ~ line 21 ~ InsertReservaMesaGrupo ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertReservaMesaGrupo = new InsertReservaMesaGrupo()

module.exports = insertReservaMesaGrupo.main.bind(insertReservaMesaGrupo)
