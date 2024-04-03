'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetColaboradorFixo extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getColaboradorFixo.js ~ line 10 ~ GetColaboradorFixo ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const ColaboradorFixo = await dbConnection.model('usuColaboradorFixo').findAll({
        where: {
          id_estabelecimento: user.id
        },
        attributes: ['id', 'id_funcao'],
        include: {
          model: dbConnection.model('Users'),
          attributes: ['id', 'nome', 'foto']
        }
      })
      return this.handlerSuccess(ColaboradorFixo)
    } catch (error) {
      console.log('🚀 ~ file: getColaboradorFixo.js ~ line 20 ~ GetColaboradorFixo ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getColaboradorFixo = new GetColaboradorFixo()

module.exports = getColaboradorFixo.main.bind(getColaboradorFixo)
