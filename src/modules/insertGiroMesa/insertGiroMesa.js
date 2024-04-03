'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertGiroDeMesa extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertGiroDeMesa.js ~ line 8 ~ InsertGiroDeMesa ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const data = this.parseEvent(event)

      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const giroMesa = await dbConnection.model('GiroMesa').bulkCreate(data)

      return this.handlerSuccess(giroMesa)
    } catch (error) {
      console.log('🚀 ~ file: InsertGiroDeMesa.js ~ line 21 ~ InsertGiroDeMesa ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertGiroDeMesa = new InsertGiroDeMesa()

module.exports = insertGiroDeMesa.main.bind(insertGiroDeMesa)
