'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class DeleteSubEvento extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: DeleteSubEvento.js ~ line 8 ~ DeleteSubEvento ~ main ~ event', event)

    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })
      if (!user) {
        throw new Error('user not found!')
      }

      const deleteSubEvento = await dbConnection.model('eveAniversario').destroy({
        where: {
          id: event.queryStringParameters.id
        }
      })

      return this.handlerSuccess(deleteSubEvento)
    } catch (error) {
      console.log('🚀 ~ file: DeleteSubEvento.js ~ line 22 ~ DeleteSubEvento ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const deleteSubEvento = new DeleteSubEvento()

module.exports = deleteSubEvento.main.bind(deleteSubEvento)
