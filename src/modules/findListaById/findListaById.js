'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class FindListaById extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: findListaById.js ~ line 10 ~ FindListaById ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const ListaPeople = await dbConnection.model('EveListaTipo').findByPk(event.pathParameters.id)

      return this.handlerSuccess(ListaPeople)
    } catch (error) {
      console.log('🚀 ~ file: findListaById.js ~ line 20 ~ FindListaById ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findListaById = new FindListaById()

module.exports = findListaById.main.bind(findListaById)
