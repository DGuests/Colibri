'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetCardapioDigital extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetCardapioDigital.js ~ line 10 ~ GetCardapioDigital ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const Categoria = await dbConnection.model('EstFinCategoria').findAll({
        where: { id_usuario: user.id },
        order: [
          ['ordem', 'ASC']
        ],
        include: [
          { model: dbConnection.model('EstFinCategoriaTraducao') },
          {
            model: dbConnection.model('EstFinCategoriaGrupo'),
            include: { model: dbConnection.model('EstFinCategoriaGrupoTraducao') }
          },

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
              },
              { model: dbConnection.model('estFinProdutosTraducao') }
            ]
          },
          { model: dbConnection.model('EstFinCategoriaHorario') }
        ]
      })

      return this.handlerSuccess(Categoria)
    } catch (error) {
      console.log('🚀 ~ file: GetCardapioDigital.js ~ line 20 ~ GetCardapioDigital ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getCardapioDigital = new GetCardapioDigital()

module.exports = getCardapioDigital.main.bind(getCardapioDigital)
