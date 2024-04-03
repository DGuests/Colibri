'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')
// const { verifyData } = require('@src/utils/validator')

class UpdateCardapio extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: updateCardapio.js ~ line 8 ~ UpdateCardapio ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)
      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const data = this.parseEvent(event)

      await dbConnection.model('UsoCardapio').upsert({
        id: data.cardapioId,
        id_usuario: user.id,
        telefone: data.telefone,
        wifiRede: data.wifiRede,
        wifi: data.wifi,
        wpp: data.wpp,
        entrega: data.entrega,
        exigeEntrega: data.exigeEntrega,
        exigeLogin: data.exigeLogin,
        observacao: data.observacao,
        templateNovo: data.templateNovo,
        tempoEntrega: data.tempoEntrega
      })

      await dbConnection.model('usuHorarioFuncionamento').upsert({
        id: data.horarioFuncionamentoId,
        id_usuario: user.id,
        seg_fim_delivery: data.seg_fim_delivery,
        seg_inicio_delivery: data.seg_inicio_delivery,
        ter_fim_delivery: data.ter_fim_delivery,
        ter_inicio_delivery: data.ter_inicio_delivery,
        qua_fim_delivery: data.qua_fim_delivery,
        qua_inicio_delivery: data.qua_inicio_delivery,
        qui_fim_delivery: data.qui_fim_delivery,
        qui_inicio_delivery: data.qui_inicio_delivery,
        sex_fim_delivery: data.sex_fim_delivery,
        sex_inicio_delivery: data.sex_inicio_delivery,
        sab_fim_delivery: data.sab_fim_delivery,
        sab_inicio_delivery: data.sab_inicio_delivery,
        dom_fim_delivery: data.dom_fim_delivery,
        dom_inicio_delivery: data.dom_inicio_delivery,
        is_show_delivery: data.is_show_delivery
      })

      return this.handlerSuccess('Teste')
    } catch (error) {
      console.log('🚀 ~ file: updateCardapio.js ~ line 22 ~ UpdateCardapio ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const updateCardapio = new UpdateCardapio()

module.exports = updateCardapio.main.bind(updateCardapio)
