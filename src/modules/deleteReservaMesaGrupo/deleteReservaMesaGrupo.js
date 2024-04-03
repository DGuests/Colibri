'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')


class DeleteReservaMesaGrupo extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: DeleteReservaMesaGrupo.js ~ line 8 ~ DeleteReservaMesaGrupo ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      let idUser = obterIdUsuario(event)

      // const authorizerContext = event?.requestContext?.authorizer ?? null

      // const verifyAccess = await verifyData('User', authorizerContext)

      if (idUser !== undefined || idUser !== null) {
        const mesa = await dbConnection.model('ReservaMesaGrupo').destroy(
          { where: { id: event.pathParameters.id } })

        return this.handlerSuccess(mesa)
      }
    } catch (error) {
      console.log('🚀 ~ file: DeleteReservaMesaGrupo.js ~ line 16 ~ DeleteReservaMesaGrupo ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const deleteReservaMesaGrupo = new DeleteReservaMesaGrupo()

module.exports = deleteReservaMesaGrupo.main.bind(deleteReservaMesaGrupo)
