'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
// const { userAttributesPick } = require('@src/utils')
// const { verifyData } = require('@src/utils/validator')
const { obterIdUsuario } = require('../../utils/index')

class InsertPromover extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertPromover.js ~ line 10 ~ InsertPromover ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const data = this.parseEvent(event)

      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const obj = {
        id_usuario: user.id,
        id_evento: data.id_evento,
        id_aniversario: data.id_aniversario,
        fbMasc: data.fbMasc,
        limiteMasc: data.limiteMasc,
        fbFem: data.fbFem,
        limiteFem: data.limiteFem
      }

      if (data.idPromover > 0) {
        const promover = await dbConnection.model('EveLinkPromover').update(obj, {
          where: {
            id: data.idPromover
          }
        })
        return this.handlerSuccess(promover)
      } else {
        const promover = await dbConnection.model('EveLinkPromover').create(obj)
        return this.handlerSuccess(promover)
      }
    } catch (error) {
      console.log('🚀 ~ file: InsertPromover.js ~ line 20 ~ InsertPromover ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertPromover = new InsertPromover()

module.exports = insertPromover.main.bind(insertPromover)
