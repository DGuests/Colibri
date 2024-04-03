'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class GetCenarioById extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetCenarioById.js ~ line 8 ~ GetCenarioById ~ main ~ event', event)
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

      const cenario = await dbConnection.model('PrmCenarioMesa').findAll({
        where: {
          id_usuario: user.id,
          id: event.pathParameters.id
        },
        attributes: ['id', 'nome'],
        include: [
          { model: dbConnection.model('ReservaMesaGrupo') },
          { model: dbConnection.model('PrmMesa') }
        ]
      })

      return this.handlerSuccess(cenario)
    } catch (error) {
      console.log('🚀 ~ file: GetCenarioById.js ~ line 16 ~ GetCenarioById ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getCenarioById = new GetCenarioById()

module.exports = getCenarioById.main.bind(getCenarioById)
