'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class InsertNewMesa extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertNewMesa.js ~ line 8 ~ InsertNewMesa ~ main ~ event', event)
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

      for (let i = 0; i < data.length; i++) {
        data[i].id_usuario = user.id
      }

      const establishment = await dbConnection.model('PrmMesa').bulkCreate(data)

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: InsertNewMesa.js ~ line 21 ~ InsertNewMesa ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertNewMesa = new InsertNewMesa()

module.exports = insertNewMesa.main.bind(insertNewMesa)
