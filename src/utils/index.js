const obterIdUsuario = require('@src/utils/obterIdUsuario')
const verifyColaborador = require('@src/utils/verifyColaborador')
const subscriptionValidation = require('@src/utils/subscriptionValidation')
const authUser = require('@src/utils/authUser')

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

module.exports = {
  pick,
  userAttributesPick,
  authUser,
  obterIdUsuario,
  verifyColaborador,
  subscriptionValidation
}
