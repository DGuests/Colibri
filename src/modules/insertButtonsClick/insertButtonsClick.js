'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { literal } = require('sequelize')

class InsertButtonsClick extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: insertButtonsClick.js:8 ~ InsertButtonsClick ~ main ~ event:', event)
    try {
      const dbConnection = await connection()

      await dbConnection.model('usuLinkCriado').update(
        { clicks: literal('n_link_click + 1') },
        {
          where: {
            id: event.pathParameters.id
          }
        }
      )

      return this.handlerSuccess({ message: 'Click registrado com sucesso!' })
    } catch (error) {
      console.log('🚀 ~ file: insertButtonsClick.js:31 ~ InsertButtonsClick ~ main ~ error:', error)
      return this.handleError(error)
    }
  }
}

const insertButtonsClick = new InsertButtonsClick()

module.exports = insertButtonsClick.main.bind(insertButtonsClick)
