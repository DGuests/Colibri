'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')
// const { verifyData } = require('@src/utils/validator')

class PostHistory extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: PostHistory.js ~ line 8 ~ PostHistory ~ main ~ event', event)
    try {
      const dbConnection = await connection()

      const data = this.parseEvent(event)
      console.log('Dados recebidos: ', data)
      let idUser = obterIdUsuario(event)

      // const authorizerContext = event?.requestContext?.authorizer ?? null
      // const verifyAccess = await verifyData('User', authorizerContext)

      if (idUser !== undefined || idUser !== null) {
        // await validationRegisterBlacklist.validateAsync(data)
        const response = await dbConnection.model('EstFinMesaPedido').findOne({
          where: { mesaId: event.pathParameters.id }
        })

        console.log('LOGGGGGG: ', response)

        const obj = {
          usuarioId: idUser,
          numero: response.mesaNumero,
          hash: response.hash,
          status: response.mesaStatus,
          dataAbertura: response.dataAbertura,
          dataFechamento: response.dataFechamento,
          token: response.token
          // qdePessoas: response.qdePessoas,
          // nota: response.nota,
          // mesaValor: response.mesaValor,
          // mesaValorServico: response.mesaValorServico,
          // mesaValorCouvert: response.mesaValorCouvert,
          // mesaValorTotal: response.mesaValorTotal,
          // mesaForma: response.mesaForma,
          // mesaSituacao: response.mesaSituacao
        }
        const establishment = await dbConnection.model('EstFinMesaHistorico').create(obj)

        return this.handlerSuccess(establishment)
      }
    } catch (error) {
      console.log('🚀 ~ file: PostHistory.js ~ line 21 ~ PostHistory ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const postHistory = new PostHistory()

module.exports = postHistory.main.bind(postHistory)
