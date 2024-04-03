function obterIdUsuario (event) {
  const authProvider = event.requestContext.identity.cognitoAuthenticationProvider
  const parts = authProvider.split(':')
  const userPoolUserId = parts[parts.length - 1]

  return userPoolUserId
}

module.exports = obterIdUsuario
