'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertReservaMesa extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertReservaMesa.js ~ line 8 ~ InsertReservaMesa ~ main ~ event', event)
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
      const mesaEspera = await dbConnection.model('PrmReservaMesa').create(data)

      return this.handlerSuccess(mesaEspera)
    } catch (error) {
      console.log('🚀 ~ file: InsertReservaMesa.js ~ line 21 ~ InsertReservaMesa ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertReservaMesa = new InsertReservaMesa()

module.exports = insertReservaMesa.main.bind(insertReservaMesa)
