'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertProduto extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertProduto.js ~ line 8 ~ InsertProduto ~ main ~ event', event)
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
      console.log('DATA', data)

      if (event.queryStringParameters?.copia === '1') {
        const produto = []
        const produtoPrecos = []
        await Promise.all(data.map(async product => {
          const prod = await dbConnection.model('estFinProdutos').create(product)

          if (product.multiplos.length > 0) {
            product.multiplos.map(async preco => {
              produtoPrecos.push({
                id_produto: prod.dataValues.id,
                nome: preco.nome,
                preco: Number(preco.preco)
              })
            })
          }

          produto.push(prod)
        }))

        console.log('🚀 ~ file: insertProduto.js:30 ~ InsertProduto ~ main ~ produtoPrecos:', produtoPrecos)
        await dbConnection.model('estFinProdutosPrecos').bulkCreate(produtoPrecos)

        // const produto = await dbConnection.model('estFinProdutos').bulkCreate(data)

        return this.handlerSuccess(produto)
      } else {
        const produto = await dbConnection.model('estFinProdutos').create(data)

        let translate = {}
        if (data.translate) {
          translate = await dbConnection.model('estFinProdutosTraducao').create({
            id_produto: produto.id,
            tituloIngles: data.translate.tituloIngles,
            descricaoIngles: data.translate.descricaoIngles,
            tituloEspanhol: data.translate.tituloEspanhol,
            descricaoEspanhol: data.translate.descricaoEspanhol
          })
        }
        console.log(translate)

        if (data.preco === null) {
          data.preco = 0
        }

        const multiPrecos = []
        if (data.multiPreco.length > 0) {
          await Promise.all(data.multiPreco?.map(async (preco) => {
            if (preco.nome !== '') {
              const resp = await dbConnection.model('estFinProdutosPrecos').create({
                id_produto: produto.id,
                nome: preco.nome,
                preco: Number(preco.preco)
              })

              multiPrecos.push(resp)
            }
          }))
        }

        const EstFinComplementos = []
        if (data.complemento.length > 0) {
          await Promise.all(data.complemento.map(async (complemento, index) => {
            const complementoObj = {
              id_produto: produto.id,
              nome: complemento.nome,
              obrigatoriedade: complemento.obrigatoriedade,
              qntMinima: complemento.qntMinima,
              qntMaxima: complemento.qntMaxima
            }
            const complementoResponse = await dbConnection.model('EstFinComplemento').create(complementoObj)

            const items = []
            await Promise.all(data.item.map(async (item) => {
              if (item.id_complemento === index) {
                const itemObj = {
                  id_complemento: complementoResponse.id,
                  nome: item.nome,
                  descricao: item.descricao,
                  preco: item.preco,
                  status: item.status
                }
                const complementoitem = await dbConnection.model('EstFinComplementoItem').create(itemObj)
                items.push(complementoitem.dataValues)
              }
            }))
            complementoResponse.dataValues.EstFinComplementoItems = items
            EstFinComplementos.push(complementoResponse)
          }))
        }

        produto.dataValues.EstFinComplementos = EstFinComplementos

        return this.handlerSuccess({ produto, multiPrecos })
      }
    } catch (error) {
      console.log('🚀 ~ file: InsertProduto.js ~ line 21 ~ InsertProduto ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertProduto = new InsertProduto()

module.exports = insertProduto.main.bind(insertProduto)
