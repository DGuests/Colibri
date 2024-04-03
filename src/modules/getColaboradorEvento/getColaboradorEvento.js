'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetColaboradorEvento extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetColaboradorEvento.js ~ line 10 ~ GetColaboradorEvento ~ main ~ event', event)
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

      const colabEvento = await dbConnection.model('eveColaborador').findAll({
        where: { id_evento: event.pathParameters.id },
        include: [
          { model: dbConnection.model('Users') },
          { model: dbConnection.model('EveFuncao') }
        ]
      })

      const ColaboradorFixo = await dbConnection.model('usuColaboradorFixo').findAll({
        where: {
          id_estabelecimento: user.id
        },
        include: [
          { model: dbConnection.model('Users') },
          { model: dbConnection.model('EveFuncao') }
        ]
      })

      ColaboradorFixo.map(colab => {
        console.log(colab)
        const existis = colabEvento.find(colabEve => (
          colabEve.dataValues?.id_colaborador === colab.dataValues.id_usuario &&
          colabEve.dataValues?.funcao === colab.dataValues.id_funcao
        ))
        console.log('🚀 ~ file: getColaboradorEvento.js:45 ~ GetColaboradorEvento ~ main ~ existis:', existis)
        if (existis === undefined) {
          colabEvento.push(colab.dataValues)
        }
      })
      return this.handlerSuccess(colabEvento)
    } catch (error) {
      console.log('🚀 ~ file: GetColaboradorEvento.js ~ line 20 ~ GetColaboradorEvento ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getColaboradorEvento = new GetColaboradorEvento()

module.exports = getColaboradorEvento.main.bind(getColaboradorEvento)
