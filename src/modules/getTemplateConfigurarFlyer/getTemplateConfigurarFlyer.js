'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetTemplateConfigurarFlyer extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetTemplateConfigurarFlyer.js ~ line 10 ~ GetTemplateConfigurarFlyer ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      if (!idUser) {
        throw new Error('user not found!')
      }

      const user = await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        }
      })

      if (user.id !== undefined || user.id !== null) {
        const template = await dbConnection.model('prmTemplate').findAll(
          {
            attributes: ['id',
              'tituloFont',
              'tituloTop',
              'templateContador',
              'tituloCor',
              'tituloText',
              'tituloTamanho',
              'tituloEspaço',
              'tituloTopMobile',
              'tituloTamanhoMobile',
              'subtituloTopMobile',
              'subtituloTamanhoMobile',
              'dataTopMobile',
              'dataTamanhoMobile',
              'enderecoTopMobile',
              'endTamanhoMobile',
              'logoTopMobile',
              'logoTamanhoMobile',
              'logoDgTamanhoMobile',
              'subtituloFont',
              'subtituloCor',
              'subtituloText',
              'subtituloTamanho',
              'subtituloTop',
              'subtituloEspaco',
              'enderecoFont',
              'enderecoCor',
              'enderecoTexto',
              'enderecoTop',
              'enderecoTamanho',
              'enderecoEspaco',
              'logoTamanho',
              'logoTop',
              'logoDgTop',
              'logoDgTamanho',
              'dataFont',
              'dataCor',
              'dataTexto',
              'dataTamanho',
              'dataTop',
              'dataEspaco']
          }
        )

        const templateLinks = await dbConnection.model('prmTemplateUsuario').findAll({
          where: { id_usuario: user.id }
        })

        const logosUser = await dbConnection.model('UsuLogo').findAll({
          where: {
            logoUsuario: user.id
          }
        })

        return this.handlerSuccess({ template, templateLinks, logosUser })
      }
    } catch (error) {
      console.log('🚀 ~ file: GetTemplateConfigurarFlyer.js ~ line 20 ~ GetTemplateConfigurarFlyer ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getTemplateConfigurarFlyer = new GetTemplateConfigurarFlyer()

module.exports = getTemplateConfigurarFlyer.main.bind(getTemplateConfigurarFlyer)
