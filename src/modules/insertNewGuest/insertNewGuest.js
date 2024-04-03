'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class InsertNewGuest extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertNewGuest.js ~ line 10 ~ InsertNewGuest ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)
      const data = this.parseEvent(event)
      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      const obj = {
        id_participante: user.id,
        id_evento: data.id_evento,
        tipoLista: data.tipoLista,
        nome: data.nome,
        documento: data.documento,
        telefone: data.telefone,
        email: data.email,
        id_convidadoPor: data.id_convidadoPor,
        id_aniversario: data.id_aniversario,
        dataCheckIn: data.dataCheckIn,
        dataNascimento: data.dataNascimento
      }

      const convidados = await dbConnection.model('EveLista').create(obj)

      return this.handlerSuccess(convidados)
    } catch (error) {
      console.log('🚀 ~ file: InsertNewGuest.js ~ line 20 ~ InsertNewGuest ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertNewGuest = new InsertNewGuest()

module.exports = insertNewGuest.main.bind(insertNewGuest)
