'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

let hash

function geraStringAleatoria (tamanho) {
  let stringAleatoria = ''
  var caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  for (let i = 0; i < tamanho; i++) {
    stringAleatoria += caracteres.charAt(Math.floor(Math.random() * caracteres.length))
  }
  hash = stringAleatoria
  return hash
}

class InsertNewTable extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: insertNewTable.js ~ line 8 ~ insertNewTable ~ main ~ event', event)
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

      const getTable = await dbConnection.model('EstFinMesa').findOne({
        where: { usuarioId: user.id },
        order: [['id', 'DESC']],
        attributes: ['id', 'numero']
      })

      let qtdMesas = getTable === null ? 0 : Number(getTable.numero)

      const table = []
      for (var i = 0; i < data; i++) {
        geraStringAleatoria(4)
        table.push({
          usuarioId: user.id,
          numero: qtdMesas + 1,
          hash,
          status: 'deleted'
        })
        qtdMesas = qtdMesas + 1
      }

      await dbConnection.model('EstFinMesa').bulkCreate(table)

      const establishment = await dbConnection.model('EstFinMesa').findAll({
        where: { usuarioId: user.id },
        include: [{
          model: dbConnection.model('EstFinMesaPedido'),
          limit: 1,
          order: [['id', 'DESC']]
        }]
      })
      return this.handlerSuccess(establishment)
    } catch (error) {
      console.log('🚀 ~ file: insertNewTable.js ~ line 21 ~ insertNewTable ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertNewTable = new InsertNewTable()

module.exports = insertNewTable.main.bind(insertNewTable)
