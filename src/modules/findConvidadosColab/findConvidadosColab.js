'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario, verifyColaborador } = require('../../utils/index')

class FindConvidadosColab extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: FindConvidadosColab.js ~ line 8 ~ FindConvidadosColab ~ main ~ event', event)
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

      const colaborador = await verifyColaborador(user, 'convidados')
      const convidadoAccess = colaborador[0].dataValues.EveFuncao.EveFuncaoAcessos[0].convidado

      let convidados = []

      const convAccessAttributesSubEvento = {
        id_evento: event.pathParameters.idEvento,
        id_aniversario: event.queryStringParameters.id,
        id_convidadoPor: colaborador[0].dataValues.id_colaborador
      }

      const accessAttributesSubEvento = {
        id_evento: event.pathParameters.idEvento,
        id_aniversario: event.queryStringParameters.id
      }

      const attributesSubEvento = convidadoAccess ? accessAttributesSubEvento : convAccessAttributesSubEvento

      const convAccessAttributesEvento = {
        id_evento: event.pathParameters.idEvento,
        id_convidadoPor: colaborador[0].dataValues.id_colaborador
      }

      const accessAttributesEvento = {
        id_evento: event.pathParameters.idEvento
      }

      const attributesEvento = convidadoAccess ? accessAttributesEvento : convAccessAttributesEvento

      if (event.queryStringParameters.id !== 'null') {
        // procura em subEvento
        await dbConnection.model('EveLista').findAll({
          where: attributesSubEvento,
          attributes: ['id', 'dataCheckIn', 'email', 'nome', 'createdAt', 'id_convidadoPor', 'tipoLista', 'foto'],
          include: [
            {
              model: dbConnection.model('eveAniversario'),
              attributes: ['nome']
            },
            {
              model: dbConnection.model('Users'),
              attributes: ['nome', 'id']
            }
          ]
        })
      } else {
        // procura em evento
        convidados = await dbConnection.model('EveLista').findAll({
          where: attributesEvento,
          attributes: ['id', 'dataCheckIn', 'email', 'nome', 'createdAt', 'id_convidadoPor', 'tipoLista', 'foto'],
          include: [
            {
              model: dbConnection.model('eveAniversario'),
              attributes: ['nome', 'createdAt']
            },
            {
              model: dbConnection.model('Users'),
              attributes: ['nome', 'id']
            }
          ]
        })
      }

      return this.handlerSuccess(convidados)
    } catch (error) {
      console.log('🚀 ~ file: FindConvidadosColab.js ~ line 16 ~ FindConvidadosColab ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findConvidadosColab = new FindConvidadosColab()

module.exports = findConvidadosColab.main.bind(findConvidadosColab)
