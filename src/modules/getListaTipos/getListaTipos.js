'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { userAttributesPick } = require('@src/utils')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class GetListaTipos extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetListaTipos.js ~ line 8 ~ GetListaTipos ~ main ~ event', event)
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

      const listas = await dbConnection.model('EveListaTipo').findAll({
        where: {
          id_estabelecimento: user.id
        },
        attributes: ['id', 'consumacao', 'cor', 'nome', 'valor']
      })

      return this.handlerSuccess(listas)
    } catch (error) {
      console.log('🚀 ~ file: GetListaTipos.js ~ line 21 ~ GetListaTipos ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getListaTipos = new GetListaTipos()

module.exports = getListaTipos.main.bind(getListaTipos)
