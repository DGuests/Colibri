'use strict'

const { BaseHandlerLambda } = require('@src/lib')
// const { validationRegisterCategoria } = require('@src/utils/validator')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertCategoria extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertCategoria.js ~ line 8 ~ InsertCategoria ~ main ~ event', event)
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

      const obj = {
        titulo: data.titulo,
        id_usuario: user.id,
        visivel: data.visivel,
        tipoCardapio: data.tipoCardapio,
        ordem: data.ordem
      }

      // await validationRegisterCategoria.validateAsync(obj)

      const categoriaCriada = await dbConnection.model('EstFinCategoria').create(obj)

      console.log('🚀 ~ file: insertCategoria.js:39 ~ InsertCategoria ~ main ~ data.translate:', data.translate)
      console.log('🚀 ~ file: insertCategoria.js:48 ~ InsertCategoria ~ awaitdbConnection.model ~ categoriaCriada:', categoriaCriada)
      if (data.translate) {
        await dbConnection.model('EstFinCategoriaTraducao').create({
          id_categoria: categoriaCriada.id,
          tituloPortugues: data.translate.tituloPortugues,
          tituloIngles: data.translate.tituloIngles,
          tituloEspanhol: data.translate.tituloEspanhol,
          obsIngles: data.translate.obsIngles,
          obsEspanhol: data.translate.obsEspanhol
        })
      }

      const categoriaIncludes = {
        ...categoriaCriada.dataValues,
        EstFinCategoriaGrupos: [],
        estFinProdutos: [],
        EstFinCategoriaHorario: []
      }

      return this.handlerSuccess(categoriaIncludes)
    } catch (error) {
      console.log('🚀 ~ file: InsertCategoria.js ~ line 21 ~ InsertCategoria ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertCategoria = new InsertCategoria()

module.exports = insertCategoria.main.bind(insertCategoria)
