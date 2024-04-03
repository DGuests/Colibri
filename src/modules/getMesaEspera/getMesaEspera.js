'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetMesaEspera extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetMesaEspera.js ~ line 10 ~ GetMesaEspera ~ main ~ event', event)
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

      const espera = await dbConnection.model('PrmMesaEspera').findAll({
        where: {
          id_evento: event.pathParameters.idEvento
        },
        attributes: ['id', 'nome', 'status', 'telefone', 'id_setor', 'email', 'capacidade', 'observacao', 'documento', 'createdAt'],
        order: [
          ['updatedAt', 'ASC']
        ]
      })
      return this.handlerSuccess(espera)
    } catch (error) {
      console.log('🚀 ~ file: GetMesaEspera.js ~ line 20 ~ GetMesaEspera ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getMesaEspera = new GetMesaEspera()

module.exports = getMesaEspera.main.bind(getMesaEspera)
