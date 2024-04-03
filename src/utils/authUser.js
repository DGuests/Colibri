const pick = (object = {}, keys = []) => keys.reduce((obj, key) => Object.assign(obj, { [key]: object[key] }), {})

const userAttributesPick = (obj) => pick(obj, [
  'birthdate',
  'email_verified',
  'name',
  'phone_number',
  'id',
  'email',
  'username',
  'profile'
])

function authUser (event) {
  const authorizerContext = event?.requestContext?.authorizer ?? null
  const userContext = userAttributesPick(authorizerContext)

  if (!userContext) {
    throw new Error('user not found!')
  }

  return userContext
}

module.exports = authUser
