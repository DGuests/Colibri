'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertOpenTables extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: testeUpdateButtonsCopyPast.js ~ line 8 ~ testeUpdateButtonsCopyPast ~ main ~ event', event)

    try {
      const dbConnection = await connection()

      const data = this.parseEvent(event)
      const idUser = obterIdUsuario(event)

      console.log('Dados recebidos: ', data)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      if (event.queryStringParameters.bulk === 'true') {
        const mesaPedido = []
        await Promise.all(
          data.map(async (item) => {
            await dbConnection.model('EstFinMesa').update({
              hash: item.hash,
              status: item.mesaStatus
            }, {
              where: {
                usuarioId: user.id,
                id: item.idMesa
              }
            })

            const response = await dbConnection.model('EstFinMesaPedido').create({
              mesaStatus: item.mesaStatus,
              dataAbertura: new Date(),
              dataFechamento: null,
              usuarioId: user.id,
              mesaId: item.idMesa,
              mesaNumero: item.mesaNumero,
              hash: item.hash,
              token: item.token
            })

            mesaPedido.push(response)
          })
        )

        return this.handlerSuccess(mesaPedido)
      }

      await dbConnection.model('EstFinMesa').update({
        hash: data.hash,
        status: data.mesaStatus
      }, {
        where: {
          usuarioId: user.id,
          id: event.queryStringParameters.mesaId
        }
      })

      const response = await dbConnection.model('EstFinMesaPedido').create({
        mesaStatus: data.mesaStatus,
        dataAbertura: new Date(),
        dataFechamento: null,
        usuarioId: user.id,
        mesaId: event.queryStringParameters.mesaId,
        mesaNumero: data.mesaNumero,
        hash: data.hash,
        token: data.token
      })

      return this.handlerSuccess(response)
    } catch (error) {
      console.log('🚀 ~ file: testeUpdateButtonsCopyPast.js ~ line 21 ~ testeUpdateButtonsCopyPast ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertOpenTables = new InsertOpenTables()

module.exports = insertOpenTables.main.bind(insertOpenTables)
