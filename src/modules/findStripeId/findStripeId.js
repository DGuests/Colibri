/* eslint-disable quotes */
const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('@src/utils')

class FindStripeId extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: FindStripeId.js ~ line 10 ~ FindStripeId ~ main ~ event', event)
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

      const customer = await dbConnection.model('PrmPremium').findOne({
        where: { id_usuario: user.id }
      })

      return this.handlerSuccess({ stripeId: customer?.stripeId, email: user.email })
    } catch (error) {
      console.log('🚀 ~ file: FindStripeId.js ~ line 20 ~ FindStripeId ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const findStripeId = new FindStripeId()

module.exports = findStripeId.main.bind(findStripeId)
