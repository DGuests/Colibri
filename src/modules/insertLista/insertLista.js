'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertLista extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: insertLista.js ~ line 8 ~ InsertLista ~ main ~ event', event)
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

      const data = this.parseEvent(event)

      const obj = {
        id_estabelecimento: user.id,
        nome: data.nome,
        cor: data.cor,
        valor: data.valor,
        data_cadastro: data.data_cadastro,
        fb: data.fb,
        status: data.status,
        sexo: data.sexo,
        consumacao: data.consumacao,
        remuneracao: data.remuneracao
      }

      const establishment = await dbConnection.model('EveListaTipo').create(obj)

      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: insertLista.js ~ line 21 ~ InsertLista ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertLista = new InsertLista()

module.exports = insertLista.main.bind(insertLista)
