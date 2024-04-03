'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertCategoriaGrupo extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertCategoriaGrupo.js ~ line 8 ~ InsertCategoriaGrupo ~ main ~ event', event)
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
      const grupo = await dbConnection.model('EstFinCategoriaGrupo').create(data.grupo)

      if (data.translate) {
        await dbConnection.model('EstFinCategoriaGrupoTraducao').create({
          id_grupo: grupo.id,
          ingles: data.translate.ingles,
          espanhol: data.translate.espanhol
        })
      }

      await Promise.all(
        data.produtos.map(async produto => {
          await dbConnection.model('estFinProdutos').update({ id_grupo: grupo.id }, {
            where: { id: produto.id }
          })
        })
      )

      return this.handlerSuccess(grupo)
    } catch (error) {
      console.log('🚀 ~ file: InsertCategoriaGrupo.js ~ line 21 ~ InsertCategoriaGrupo ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertCategoriaGrupo = new InsertCategoriaGrupo()

module.exports = insertCategoriaGrupo.main.bind(insertCategoriaGrupo)
