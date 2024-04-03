/* eslint-disable camelcase */
const {
  CognitoUser,
  CognitoUserPool,
  AuthenticationDetails,
  CognitoUserAttribute,
  CognitoRefreshToken
} = require('amazon-cognito-identity-js')

global.fetch = require('node-fetch')

/**
* @typedef {object} CodeDeliveryDetails
* @property {string} AttributeName
* @property {string} DeliveryMedium
* @property {string} Destination
*/

class AuthCognitoModule {
  /**
   * @param {object} poolData
   * @param {string} poolData.UserPoolId
   * @param {string} poolData.ClientId
   * @param {string} poolRegion
   */
  constructor (poolData, poolRegion) {
    this.poolData = poolData
    // this.poolRegion = poolRegion || 'us-east-1'
    this.poolRegion = poolRegion || 'us-west-2'
    this.userPool = new CognitoUserPool(poolData)
  }

  /**
   *
   * @param {string} username
   * @param {import('amazon-cognito-identity-js').CognitoUserPool} pool
   */
  static cognitoUser (username, pool) {
    return new CognitoUser({
      Username: username,
      Pool: pool
    })
  }

  /**
   *
   * @param {object} authenticationData
   * @param {string} authenticationData.Username
   * @param {string} authenticationData.Password
   */
  static authenticationDetails (authenticationData) {
    return new AuthenticationDetails(authenticationData)
  }

  /**
   *
   * @param {object} attributes
   * @param {string} attributes.name
   * @param {string} attributes.email
   * @param {string} attributes.phone_number
   * @param {string} attributes.birthdate
   */
  static buildCognitoUser ({ name, email, phone_number, birthdate }) {
    const cognitoUserAttribute = [
      new CognitoUserAttribute({ Name: 'name', Value: name }),
      new CognitoUserAttribute({ Name: 'birthdate', Value: birthdate }),
      new CognitoUserAttribute({ Name: 'phone_number', Value: phone_number }),
      new CognitoUserAttribute({ Name: 'email', Value: email })
    ]
    console.log('AuthCognitoModule -> buildCognitoUser -> cognitoUserAttribute', cognitoUserAttribute)

    return cognitoUserAttribute
  }

  /**
   *
   * @typedef {import('amazon-cognito-identity-js').ISignUpResult} SignUpResult
   */

  /**
   *
   * @param {object} user
   * @param {string} user.name
   * @param {string} user.email
   * @param {string} user.phone_number
   * @param {string} user.password
   * @param {string} user.birthdate
   * @returns {Promise<SignUpResult, Error>}
   */
  signUp (user) {
    const { email, password } = user
    const attributeList = AuthCognitoModule.buildCognitoUser(user)
    return new Promise((resolve, reject) => {
      this.userPool.signUp(
        email.split('@')[0],
        password,
        attributeList,
        null,
        (err, result) => {
          if (err) reject(err)
          resolve(result)
        }
      )
    })
  }

  /**
   *
   * @param {object} user
   * @param {string} user.username
   * @param {string} user.smsCode
   * @returns {Promise<string>}
   */
  confirmRegistration ({ username, smsCode }) {
    const cognitoUser = AuthCognitoModule.cognitoUser(username, this.userPool)
    return new Promise((resolve, reject) => {
      cognitoUser.confirmRegistration(smsCode, true, (err, result) => {
        if (err) reject(err)
        resolve(result)
      })
    })
  }

  /**
   *
   * @param {object} authenticationData
   * @param {string} authenticationData.username
   * @param {string} authenticationData.password
   */
  signIn ({ username, password }) {
    const cognitoUser = AuthCognitoModule.cognitoUser(username, this.userPool)
    const authenticationDetails = AuthCognitoModule
      .authenticationDetails({
        Username: username,
        Password: password
      })
    return new Promise((resolve, reject) => {
      cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: function (result) {
          resolve({
            accessToken: result.getAccessToken().getJwtToken(),
            idToken: result.getIdToken().getJwtToken(),
            refreshToken: result.getRefreshToken().getToken(),
            payload: result.getAccessToken().payload,
            isValid: result.isValid()
          })
        },
        onFailure: function (err) {
          reject(err)
        }
      })
    })
  }

  /**
   *
   * @param {object} user
   * @param {string} user.username
   * @param {string} user.oldPassword
   * @param {string} user.newPassword
   * @returns {Promise<CodeDeliveryDetails | 'SUCCESS' , Error>}
   */
  changePassword ({ username, oldPassword, newPassword }) {
    const cognitoUser = AuthCognitoModule.cognitoUser(username, this.userPool)
    const authenticationDetails = AuthCognitoModule.authenticationDetails({
      Username: username,
      Password: oldPassword
    })
    return new Promise((resolve, reject) => {
      cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: function (resultSuccess) {
          return cognitoUser.changePassword(
            oldPassword,
            newPassword,
            (err, result) => {
              if (err) reject(err)
              resolve(result)
            })
        },
        onFailure: function (err) {
          reject(err)
        }
      })
    })
  }

  /**
   * @description esta chamada é para usar depois do forgotPassword
   * @param {object} user
   * @param {string} user.username
   * @param {string} user.smsCode
   * @param {string} user.newPassword
   * @returns {Promise<String, Error>}
   */
  confirmPassword ({ username, smsCode, newPassword }) {
    const cognitoUser = AuthCognitoModule.cognitoUser(username, this.userPool)

    return new Promise((resolve, reject) => {
      cognitoUser.confirmPassword(smsCode, newPassword, {
        onSuccess () {
          resolve('Password confirmed!')
        },
        onFailure (err) {
          reject(err)
        }
      })
    })
  }

  /**
   * @typedef {object} ForgotPasswordData
   * @property {CodeDeliveryDetails} CodeDeliveryDetails
   *
   * @typedef {object} forgotPasswordResponse
   * @property {string} message
   * @property {ForgotPasswordData} data
   *
   * @param {object} user
   * @param {string} user.username
   * @returns {Promise<forgotPasswordResponse, Error>} { data, message: 'CodeDeliveryData from forgotPassword'}
   */
  forgotPassword ({ username }) {
    const cognitoUser = AuthCognitoModule.cognitoUser(username, this.userPool)

    return new Promise((resolve, reject) => {
      cognitoUser.forgotPassword({
        onSuccess: function (data) {
          resolve({ data, message: 'CodeDeliveryData from forgotPassword' })
        },
        onFailure: function (err) {
          reject(err)
        }
      })
    })
  }

  /**
   * @typedef {object} CognitoUserSessionData
   * @property {string} CognitoUserSessionData.accessToken
   * @property {string} CognitoUserSessionData.idToken
   * @property {string} CognitoUserSessionData.refreshToken
   *
   * @param {object} user
   * @param {string} user.username
   * @param {string} user.refreshTokenUser
   * @return {Promise<CognitoUserSessionData>}
   */
  refreshToken ({ username, refreshTokenUser }) {
    const cognitoUser = AuthCognitoModule.cognitoUser(username, this.userPool)

    const RefreshToken = new CognitoRefreshToken({
      RefreshToken: refreshTokenUser
    })

    return new Promise((resolve, reject) => {
      cognitoUser.refreshSession(RefreshToken, (err, result) => {
        if (err) reject(err)
        resolve({
          accessToken: result.getAccessToken().getJwtToken(),
          idToken: result.getIdToken().getJwtToken(),
          refreshToken: result.getRefreshToken().getToken()
        })
      })
    })
  }

  /**
   * @param {object} user
   * @param {string} user.username
   * @returns {Promise<String, Error>}
   */
  resendConfirmationCode ({ username }) {
    const cognitoUser = AuthCognitoModule.cognitoUser(username, this.userPool)

    return new Promise((resolve, reject) => {
      cognitoUser.resendConfirmationCode((err, result) => {
        if (err) reject(err)
        resolve(result)
      })
    })
  }
}

module.exports = AuthCognitoModule
