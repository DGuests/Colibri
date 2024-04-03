const Stripe = require('stripe')
// @ts-ignore
const stripe = new Stripe(
  process.env.STRIPE_API_KEY,
  {
    apiVersion: '2020-08-27',
    appInfo: {
      name: 'linkbio',
      version: '0.0.1'
    }
  }
)
module.exports.stripe = stripe
