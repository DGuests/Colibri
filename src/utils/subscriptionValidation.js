const connection = require('@src/models')
const { stripe } = require('@src/stripe/stripe')

async function subscriptionValidation (id, modulo) {
  const dbConnection = await connection()

  const subscription = await dbConnection.model('PrmPremium').findOne({
    where: {
      id_usuario: id
    },
    attributes: [
      'stripeId',
      'subscription',
      'subscriptionStart',
      'subscriptionEventos',
      'subscriptionReservas',
      'subscriptionMarketing',
      'subscriptionCardapio',
      'premiumStart',
      'premiumPremium',
      'premiumEventos',
      'premiumReservas',
      'premiumMarketing',
      'premiumCardapio'
    ]
  })

  if (subscription.premiumPremium) {
    return { status: true, message: 'Usuário possui assinatura válida' }
  }

  const { status } = await stripe.subscriptions.retrieve(subscription.subscription)

  if (status === 'active') {
    await dbConnection.model('PrmPremium').update(
      { premiumStart: true },
      { where: { id_usuario: id } }
    )
    return { status: true, message: 'Usuário possui assinatura válida' }
  }

  if (subscription[`premium${modulo}`]) {
    return { status: true, message: 'Usuário possui assinatura válida' }
  }

  const { status: moduloStatus } = await stripe.subscriptions.retrieve(subscription[`subscription${modulo}`])

  if (moduloStatus === 'active') {
    await dbConnection.model('PrmPremium').update(
      { [`premium${modulo}`]: true },
      { where: { id_usuario: id } }
    )
    return { status: true, message: 'Usuário possui assinatura válida' }
  }

  return { status: false, message: 'Usuário não possui assinatura válida' }
}

module.exports = subscriptionValidation
