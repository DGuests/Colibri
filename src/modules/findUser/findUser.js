'use strict'

const { BaseHandlerLambda } = require('@src/lib')
// const { validationUserRequest } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

const connection = require('@src/models')

class FindUser extends BaseHandlerLambda {
  async main (event) {
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

      const editarPerfil = [
        {
          model: dbConnection.model('ocEstabelecimento'),
          attributes: ['id', 'id_usuario', 'id_tipo_1', 'id_tipo_2', 'id_tipo_3', 'preco', 'descricao', 'site', 'vallet', 'vallet_valor', 'show_pet_friendly', 'notificacao_email'],
          include: [
            {
              model: dbConnection.model('ocEstabelecimentoHashtags'),
              attributes: ['id', 'hashtag']
            }
          ]
        },
        {
          model: dbConnection.model('UsoCardapio'),
          attributes: ['id', 'wifi', 'wifiRede', 'corCardapio']
        },
        {
          model: dbConnection.model('usuHorarioFuncionamento'),
          attributes: ['id', 'is_show', 'is_show_delivery', 'seg_inicio', 'seg_inicio2', 'seg_fim', 'seg_fim2', 'ter_inicio', 'ter_inicio2', 'ter_fim', 'ter_fim2', 'qua_inicio', 'qua_inicio2', 'qua_fim', 'qua_fim2', 'qui_inicio', 'qui_inicio2', 'qui_fim', 'qui_fim2', 'sex_inicio', 'sex_inicio2', 'sex_fim', 'sex_fim2', 'sab_inicio', 'sab_inicio2', 'sab_fim', 'sab_fim2', 'dom_inicio', 'dom_inicio2', 'dom_fim', 'dom_fim2']
        },
        {
          model: dbConnection.model('UsuCardapioMeioPagamento'),
          attributes: ['id', 'pagamentoShow', 'pagamentoDinheiro', 'pagamentoPIX', 'pagamentoCartaoCredito', 'pagamentoCartaoDebito', 'pagamentoValeRefeicao']
        }
      ]

      const configurarCardapio = [
        {
          model: dbConnection.model('UsoCardapio'),
          attributes: ['id', 'wpp', 'exigeLogin', 'exigeEntrega', 'telefone', 'entrega', 'tempoEntrega', 'observacao', 'wifi', 'wifiRede', 'corCardapio']
        },
        {
          model: dbConnection.model('usuHorarioFuncionamento'),
          attributes: ['id', 'is_show', 'is_show_delivery', 'seg_inicio_delivery', 'seg_fim_delivery', 'ter_inicio_delivery', 'ter_fim_delivery', 'qua_inicio_delivery', 'qua_fim_delivery', 'qui_inicio_delivery', 'qui_fim_delivery', 'sex_inicio_delivery', 'sex_fim_delivery', 'sab_inicio_delivery', 'sab_fim_delivery', 'dom_inicio_delivery', 'dom_fim_delivery']
        }
      ]

      const result = await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        },
        attributes: ['id', 'slug', 'nome', 'email', 'celular', 'foto', 'banner', 'instagram', 'facebook', 'endereco'],
        include: event.queryStringParameters?.getAll ? editarPerfil : event.queryStringParameters?.ConfCard ? configurarCardapio : null
      })

      return this.handlerSuccess(result)
    } catch (error) {
      console.log('🚀 ~ file: findUser.js ~ line 38 ~ FindUser ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findUser = new FindUser()

module.exports = findUser.main.bind(findUser)
