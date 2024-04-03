'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class UpdateTables extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: testeUpdateButtonsCopyPast.js ~ line 8 ~ testeUpdateButtonsCopyPast ~ main ~ event', event)

    try {
      const dbConnection = await connection()

      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      if (event.queryStringParameters.bulk === 'true') {
        await Promise.all(
          data.map(async (item) => {
            await dbConnection.model('EstFinMesa').update({
              hash: item.hash,
              status: item.mesaStatus === 'closed' && 'deleted'
            }, {
              where: {
                usuarioId: user.id,
                id: item.idMesa
              }
            })

            if (item.token) {
              await dbConnection.model('EstFinMesaPedido').update({
                mesaStatus: item.mesaStatus,
                dataAbertura: new Date(),
                dataFechamento: null,
                mesaNumero: item.mesaNumero,
                usuarioId: user.id,
                mesaId: item.idMesa,
                hash: item.hash,
                token: item?.token
              }, {
                where: {
                  hash: item.hash,
                  token: item?.token
                }
              })
            }
          })
        )
        return this.handlerSuccess({ message: 'success' })
      }

      await dbConnection.model('EstFinMesa').update({
        hash: data.hash,
        status: data.mesaStatus === 'closed' && 'deleted'
      }, {
        where: {
          usuarioId: user.id,
          id: event.queryStringParameters.mesaId
        }
      })

      if (data.token) {
        const response = await dbConnection.model('EstFinMesaPedido').update({
          mesaStatus: data.mesaStatus,
          dataAbertura: new Date(),
          dataFechamento: null,
          mesaNumero: data.mesaNumero,
          usuarioId: user.id,
          mesaId: event.queryStringParameters.mesaId,
          hash: data.hash,
          token: data?.token
        }, {
          where: {
            hash: data.hash,
            token: data?.token
          }
        })

        return this.handlerSuccess(response)
      }

      return this.handlerSuccess({ message: 'success' })
    } catch (error) {
      console.log('🚀 ~ file: testeUpdateButtonsCopyPast.js ~ line 21 ~ testeUpdateButtonsCopyPast ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const updateTables = new UpdateTables()

module.exports = updateTables.main.bind(updateTables)
