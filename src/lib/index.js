const AuthCognitoModule = require('./AuthCognitoModule')
const BaseHandlerLambda = require('./BaseHandlerLambda')

const poolData = {
  UserPoolId: process.env.USER_POOL_ID,
  ClientId: process.env.CLIENT_ID
}
const poolRegion = process.env.REGION_POOL
const AuthCognito = new AuthCognitoModule(poolData, poolRegion)

module.exports = {
  AuthCognito,
  BaseHandlerLambda
}
