/* eslint-disable quotes */
const { BaseHandlerLambda } = require("@src/lib")
const { stripe } = require("@src/stripe/stripe")
const connection = require('@src/models')
const { userAttributesPick } = require("@src/utils")
const { obterIdUsuario } = require('../../../../utils/index')

class GetHistoricoPagamentoStripe extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetHistoricoPagamentoStripe.js ~ line 10 ~ GetHistoricoPagamentoStripe ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      let idUser = obterIdUsuario(event)

      // const authorizerContext = event?.requestContext?.authorizer ?? null

      // const userContext = userAttributesPick(authorizerContext)

      // if (!userContext) {
      //   throw new Error('user not found!')
      // }

      const user = await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        }
      })

      if (user.id !== undefined || user.id !== null) {
        const customer = await dbConnection.model('PrmPremium').findOne({
          where: { id_usuario: user.id }
        })

        const customerId = customer?.stripeId

        const paymentIntents = await stripe.paymentIntents.list({
          customer: customerId,
          limit: 32
          // customer: 'cus_Hjq567VJN4EcaV'
        })

        console.log('RESPOSTA: ', paymentIntents)

        return this.handlerSuccess(paymentIntents)
      }
    } catch (error) {
      console.log('🚀 ~ file: GetHistoricoPagamentoStripe.js ~ line 20 ~ GetHistoricoPagamentoStripe ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getHistoricoPagamentoStripe = new GetHistoricoPagamentoStripe()

module.exports = getHistoricoPagamentoStripe.main.bind(getHistoricoPagamentoStripe)
