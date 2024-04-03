'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class DeleteUser extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: deleteUser.js ~ line 8 ~ DeleteUser ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const establishment = await dbConnection.model('Users').destroy({ where: { id: event.pathParameters.id } })

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: deleteUser.js ~ line 16 ~ DeleteUser ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const deleteUser = new DeleteUser()

module.exports = deleteUser.main.bind(deleteUser)
