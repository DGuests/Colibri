'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class UpdateCategoriaGrupo extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: UpdateCategoriaGrupo.js ~ line 8 ~ UpdateCategoriaGrupo ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const data = this.parseEvent(event)
      const idUser = obterIdUsuario(event)
      const produtosParaRemoverGrupo = []

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const categoria = await dbConnection.model('EstFinCategoriaGrupo').update(data.grupo, {
        where: { id: event.pathParameters.id }
      })

      const produtosComEsseGrupo = await dbConnection.model('estFinProdutos').findAll({
        where: { id_grupo: event.pathParameters.id }
      })

      await Promise.all(produtosComEsseGrupo.map(produto => {
        const procuraProduto = data.produtos.find(prod => prod.id === produto.dataValues.id)
        if (procuraProduto === undefined) {
          produtosParaRemoverGrupo.push(produto.dataValues.id)
        }
      }))

      if (data.produtos.length > 0) {
        await Promise.all(data.produtos.map(async produto => {
          await dbConnection.model('estFinProdutos').update({ id_grupo: event.pathParameters.id }, {
            where: { id: produto.id }
          })
        }))
      }

      if (produtosParaRemoverGrupo.length > 0) {
        await Promise.all(produtosParaRemoverGrupo.map(async produto => {
          await dbConnection.model('estFinProdutos').update({ id_grupo: null }, {
            where: { id: produto }
          })
        }))
      }

      return this.handlerSuccess(categoria)
    } catch (error) {
      console.log('🚀 ~ file: UpdateCategoriaGrupo.js ~ line 22 ~ UpdateCategoriaGrupo ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const updateCategoriaGrupo = new UpdateCategoriaGrupo()

module.exports = updateCategoriaGrupo.main.bind(updateCategoriaGrupo)
