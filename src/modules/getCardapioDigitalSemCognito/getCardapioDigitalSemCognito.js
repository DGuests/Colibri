'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class GetCardapioDigitalSemCognito extends BaseHandlerLambda {
  async main(event) {
    console.log('🚀 ~ file: getCardapioDigitalSemCognito.js ~ line 10 ~ getCardapioDigitalSemCognito ~ main ~ event', event)

    try {
      const dbConnection = await connection()

      const Categoria = await dbConnection.model('EstFinCategoria').findAll({
        where: { id_usuario: event.pathParameters.id_usuario },
        include: [
          { model: dbConnection.model('EstFinCategoriaGrupo') },

          {
            model: dbConnection.model('estFinProdutos'),
            include: [
              {
                model: dbConnection.model('estFinProdutosPrecos'),
                separate: true,
                order: [
                  ['preco', 'ASC']
                ]
              },
              {
                model: dbConnection.model('EstFinComplemento'),
                include: { model: dbConnection.model('EstFinComplementoItem') }
              }
            ]
          },
          { model: dbConnection.model('EstFinCategoriaHorario') }
        ]
      })

      return this.handlerSuccess(Categoria)
    } catch (error) {
      console.log('🚀 ~ file: getCardapioDigitalSemCognito.js ~ line 20 ~ getCardapioDigitalSemCognito ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getCardapioDigitalSemCognito = new GetCardapioDigitalSemCognito()

module.exports = getCardapioDigitalSemCognito.main.bind(getCardapioDigitalSemCognito)
