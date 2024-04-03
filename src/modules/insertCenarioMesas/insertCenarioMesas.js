'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')
class InsertCenarioMesas extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertCenarioMesas.js ~ line 8 ~ InsertCenarioMesas ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)
      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)

      const obj = {
        id_usuario: user.id,
        nome: data.nome
      }

      const cenario = await dbConnection.model('PrmCenarioMesa').create(obj)

      const response = {
        id: cenario.id,
        nome: cenario.nome,
        ReservaMesaGrupos: [],
        PrmMesas: []
      }

      return this.handlerSuccess(response)
    } catch (error) {
      console.log('🚀 ~ file: InsertCenarioMesas.js ~ line 21 ~ InsertCenarioMesas ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertCenarioMesas = new InsertCenarioMesas()

module.exports = insertCenarioMesas.main.bind(insertCenarioMesas)
