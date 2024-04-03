'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetListaTiposEvento extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetListaTiposEvento.js ~ line 8 ~ GetListaTiposEvento ~ main ~ event', event)
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

      const listasEvento = await dbConnection.model('EveListaTipoEvento').findAll({
        where: {
          id_evento: event.pathParameters.idEvento
        }
      })

      const listas = await dbConnection.model('EveListaTipo').findAll({
        where: {
          id_estabelecimento: user.id
        }
      })

      return this.handlerSuccess({ listasEvento, listas })
    } catch (error) {
      console.log('🚀 ~ file: GetListaTiposEvento.js ~ line 21 ~ GetListaTiposEvento ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getListaTiposEvento = new GetListaTiposEvento()

module.exports = getListaTiposEvento.main.bind(getListaTiposEvento)
