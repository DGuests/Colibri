'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class UpdateCategoria extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: UpdateCategoria.js ~ line 8 ~ UpdateCategoria ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const data = this.parseEvent(event)
      let idUser = obterIdUsuario(event)


      // const authorizerContext = event?.requestContext?.authorizer ?? null
      // const verifyAccess = await verifyData('User', authorizerContext)

      if (idUser !== undefined || idUser !== null) {
        if (data.horarioEspecifico === false && data.idCategoriaHorario !== undefined) {
          await dbConnection.model('EstFinCategoriaHorario').destroy({
            where: { id: data.idCategoriaHorario }
          })
        } else if (data.horarioEspecifico === true) {
          const obj = {
            id: data.idCategoriaHorario,
            inicioSegunda: data.inicioSegunda,
            fimSegunda: data.fimSegunda,
            inicioTerca: data.inicioTerca,
            fimTerca: data.fimTerca,
            inicioQuarta: data.inicioQuarta,
            fimQuarta: data.fimQuarta,
            inicioQuinta: data.inicioQuinta,
            fimQuinta: data.fimQuinta,
            inicioSexta: data.inicioSexta,
            fimSexta: data.fimSexta,
            inicioSabado: data.inicioSabado,
            fimSabado: data.fimSabado,
            inicioDomingo: data.inicioDomingo,
            fimDomingo: data.fimDomingo,
            id_categoria: data.id
          }

          await dbConnection.model('EstFinCategoriaHorario').upsert(obj)
        }

        if (data.visivel === false) {
          const produtos = await dbConnection.model('estFinProdutos').findAll({
            where: { id_categoria: event.pathParameters.id }
          })

          await Promise.all(produtos.map(async (produto) => {
            const visiveel = { visivel: false }
            await dbConnection.model('estFinProdutos').update(visiveel, {
              where: { id: produto.id }
            })
          }))
        }

        const categoria = await dbConnection.model('EstFinCategoria').update(data, {
          where: { id: event.pathParameters.id }
        })

        return this.handlerSuccess(categoria)
      }
    } catch (error) {
      console.log('🚀 ~ file: UpdateCategoria.js ~ line 22 ~ UpdateCategoria ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const updateCategoria = new UpdateCategoria()

module.exports = updateCategoria.main.bind(updateCategoria)
