'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class UpdateProduto extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: UpdateProduto.js ~ line 8 ~ UpdateProduto ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)

      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      const produto = await dbConnection.model('estFinProdutos').update(data, {
        where: { id: event.pathParameters.id }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      if (data.preco === null) {
        data.preco = 0
      }

      if (data.translate) {
        await dbConnection.model('estFinProdutosTraducao').upsert(data.translate)
      }

      if (data.multiPreco !== null && data.multiPreco !== undefined) {
        await dbConnection.model('estFinProdutosPrecos').destroy({ where: { id_produto: event.pathParameters.id } })
        await Promise.all(data.multiPreco?.map(async (preco) => {
          if (preco.nome !== '') {
            const obj = {
              id: preco.id > 0 ? preco.id : null,
              id_produto: event.pathParameters.id,
              nome: preco.nome,
              preco: parseFloat(preco.preco)
            }
            await dbConnection.model('estFinProdutosPrecos').upsert(obj, { where: { id: obj.id } })
          }
        }))
      }

      if (data.complemento) {
        await Promise.all(data.complemento.map(async (complemento, index) => {
          complemento.id_produto = event.pathParameters.id
          var complementoCriado
          await dbConnection.model('EstFinComplemento').upsert(complemento, { where: { id: complemento.id } }).then(res => {
            complementoCriado = res[0].dataValues.id
          })
          await Promise.all(data.item.map(async (item) => {
            console.log('TODOS OS IDs: ', item.id)
            if (item.id !== undefined) {
              await dbConnection.model('EstFinComplementoItem').update(item, { where: { id: item.id } })
            } else if (item.id === undefined && item.id_complemento === index) {
              item.id_complemento = complementoCriado
              await dbConnection.model('EstFinComplementoItem').create(item)
            }
          }))
        }))
      }

      return this.handlerSuccess(produto)
    } catch (error) {
      console.log('🚀 ~ file: UpdateProduto.js ~ line 22 ~ UpdateProduto ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const updateProduto = new UpdateProduto()

module.exports = updateProduto.main.bind(updateProduto)
