'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class GetUsoCardapio extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getUsoCardapio.js ~ line 10 ~ getUsoCardapio ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const data = this.parseEvent(event)

      console.log('Dados recebidos: ', data)
      const user = await dbConnection.model('Users').findOne({
        where: { slug: event.pathParameters.slug }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      if (event.queryStringParameters?.active === '1') {
        const cardapio = await dbConnection.model('UsoCardapio').findOne({
          where: { id_usuario: user.id },
          attributes: ['avaliacao', 'id_usuario']
        })

        return this.handlerSuccess(cardapio)
      } else {
        const cardapio = await dbConnection.model('UsoCardapio').findOne({
          where: { id_usuario: user.id }
        })

        const categoria = await dbConnection.model('EstFinCategoria').findAll({
          where: {
            id_usuario: user.id,
            visivel: true
          },
          order: [
            ['ordem', 'ASC']
          ],
          include: [
            { model: dbConnection.model('EstFinCategoriaHorario') },
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

        return this.handlerSuccess({ cardapio, categoria })
      }
    } catch (error) {
      console.log('🚀 ~ file: getUsoCardapio.js ~ line 20 ~ getUsoCardapio ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getUsoCardapio = new GetUsoCardapio()

module.exports = getUsoCardapio.main.bind(getUsoCardapio)
