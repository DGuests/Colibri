'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class GetCenarioMesas extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetCenarioMesas.js ~ line 8 ~ GetCenarioMesas ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (event.queryStringParameters?.page === 'evento') {
        const cenario = await dbConnection.model('PrmCenarioMesa').findAll({
          where: {
            id_usuario: user.id
          },
          attributes: ['id', 'nome']
        })
        return this.handlerSuccess(cenario)
      } else {
        const cenario = await dbConnection.model('PrmCenarioMesa').findAll({
          where: {
            id_usuario: user.id
          },
          attributes: ['id', 'nome']
          // include: [
          //   { model: dbConnection.model('ReservaMesaGrupo') },
          //   {
          //     model: dbConnection.model('PrmMesa'),
          //     include: [
          //       { model: dbConnection.model('ReservaMesaGrupo') }
          //     ]
          //   }
          // ]
        })
        return this.handlerSuccess(cenario)
      }
    } catch (error) {
      console.log('🚀 ~ file: GetCenarioMesas.js ~ line 16 ~ GetCenarioMesas ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getCenarioMesas = new GetCenarioMesas()

module.exports = getCenarioMesas.main.bind(getCenarioMesas)
