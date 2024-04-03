'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')

class GetUser extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: getUser.js ~ line 10 ~ GetUser ~ main ~ event', event)
    // const { userId } = event.pathParameters
    try {
      const dbConnection = await connection()
      const data = this.parseEvent(event)

      console.log('Dados recebidos: ', data)
      const users = await dbConnection.model('Users').findOne({
        where: { slug: event.pathParameters.slug },
        include: [
          {
            model: dbConnection.model('ocEstabelecimento'),
            attributes: ['id', 'id_usuario', 'id_tipo_1', 'id_tipo_2', 'id_tipo_3', 'preco', 'descricao', 'site', 'vallet', 'mostrar_localizacao_mapa', 'mostrar_localizacao_mapa_botoes', 'show_pet_friendly'],
            include: [
              { model: dbConnection.model('ocEstabelecimentoHashtags') },
              { model: dbConnection.model('ocEstabelecimentoTipo'), as: 'Tipo1' },
              { model: dbConnection.model('ocEstabelecimentoTipo'), as: 'Tipo2' },
              { model: dbConnection.model('ocEstabelecimentoTipo'), as: 'Tipo3' }
            ]
          },
          {
            model: dbConnection.model('UsoCardapio')
            // attributes: ['id', 'id_usuario', 'corCardapio', 'wifiRede', 'wifi']
          },
          { model: dbConnection.model('usuHorarioFuncionamento') },
          { model: dbConnection.model('UsuCardapioMeioPagamento') }
        ]
      })

      return this.handlerSuccess(users)
    } catch (error) {
      console.log('🚀 ~ file: getUser.js ~ line 20 ~ GetUser ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getUser = new GetUser()

module.exports = getUser.main.bind(getUser)
