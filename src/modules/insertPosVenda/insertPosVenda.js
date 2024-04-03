'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertPosVenda extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertPosVenda.js ~ line 8 ~ InsertPosVenda ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const data = this.parseEvent(event)

      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const obj = {
        wppLido: data.wppLido,
        id_convidado: data.id_convidado,
        id_usuario: user.id,
        id_reserva: data.id_reserva,
        id_avaliacao: data.id_avaliacao,
        id_cardapio: data.id_cardapio,
        id_espera: data.id_espera
      }

      const establishment = await dbConnection.model('PrmPosVenda').create(obj)

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: InsertPosVenda.js ~ line 21 ~ InsertPosVenda ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertPosVenda = new InsertPosVenda()

module.exports = insertPosVenda.main.bind(insertPosVenda)
