'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class FindUserByUserName extends BaseHandlerLambda {
  async main(event) {
    try {
      const dbConnection = await connection()
      const includes = [
        {
          model: dbConnection.model('usuHorarioFuncionamento'),
          attributes: ['id', 'is_show', 'is_show_delivery', 'seg_inicio', 'seg_inicio2', 'seg_fim', 'seg_fim2', 'ter_inicio', 'ter_inicio2', 'ter_fim', 'ter_fim2', 'qua_inicio', 'qua_inicio2', 'qua_fim', 'qua_fim2', 'qui_inicio', 'qui_inicio2', 'qui_fim', 'qui_fim2', 'sex_inicio', 'sex_inicio2', 'sex_fim', 'sex_fim2', 'sab_inicio', 'sab_inicio2', 'sab_fim', 'sab_fim2', 'dom_inicio', 'dom_inicio2', 'dom_fim', 'dom_fim2']
        },
        {
          model: dbConnection.model('ocEstabelecimento'),
          attributes: ['descricao', 'vallet_valor']
        },
        {
          model: dbConnection.model('UsuCardapioMeioPagamento'),
          attributes: ['pagamentoDinheiro', 'pagamentoCartaoCredito', 'pagamentoCartaoDebito', 'pagamentoValeRefeicao', 'pagamentoPIX']
        },
        {
          model: dbConnection.model('usuLinkCriado'),
          attributes: ['url', 'texto', 'ordem', 'id']
        },
        {
          model: dbConnection.model('usuLink'),
          attributes: ['reserva_mesa', 'delivery', 'cardapio', 'nome_lista', 'espera', 'avaliacao', 'localizacao']
        },
        {
          model: dbConnection.model('UsoCardapio'),
          attributes: ['id', 'wifi', 'wifiRede', 'corCardapio']
        }
      ]

      if (event?.queryStringParameters?.logo === 'true') {
        const result = await dbConnection.model('Users').findOne({
          where: {
            slug: event.pathParameters.slug
          },
          attributes: ['foto']
        })
        return this.handlerSuccess(result)
      }

      const result = await dbConnection.model('Users').findOne({
        where: {
          slug: event.pathParameters.slug
        },
        attributes: ['foto', 'latitude', 'longitude', 'nome', 'endereco', 'banner', 'instagram', 'celular', 'facebook'],
        include: includes
      })

      return this.handlerSuccess(result)
    } catch (error) {
      console.log('🚀 ~ file: findUserByUserName.js ~ line 38 ~ findUserByUserName ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findUserByUserName = new FindUserByUserName()

module.exports = findUserByUserName.main.bind(findUserByUserName)
