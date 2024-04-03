'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class InsertEventos extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: InsertEventos.js ~ line 8 ~ InsertEventos ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const data = this.parseEvent(event)
      console.log('DADOS RECEBIDOS: ', data)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })
      for (let i = 0; i < data.length; i++) {
        data[i].eveUsuario = user.id
        // if (data[i].eveDataEvento.length !== 19) {
        //   const datinha = data[i].eveDataEvento + '00:00:00'
        //   const datinha2 = data[i].eveDataEvento + ' 00:00:00'
        //   if (datinha.length === 19) {
        //     console.log(new Date(data[i].eveDataFimEvento, 0, 0, 0, 0))
        //     // console.log(moment(datinha).format('YYYY-MM-DD HH:mm:ss'))
        //     data[i].eveDataEvento = moment(datinha).format('YYYY-MM-DD HH:mm:ss')
        //   } else if (datinha.length === 18) {
        //     console.log(new Date(data[i].eveDataFimEvento, 0, 0, 0, 0))
        //     // console.log(moment(datinha2).format('YYYY-MM-DD HH:mm:ss'))
        //     data[i].eveDataEvento = moment(datinha2).format('YYYY-MM-DD HH:mm:ss')
        //   }
        // }

        // if (data[i].eveDataInicioEvento.length !== 19) {
        //   const datinha = data[i].eveDataInicioEvento + '00:00:00'
        //   const datinha2 = data[i].eveDataInicioEvento + ' 00:00:00'
        //   if (datinha.length === 19) {
        //     console.log(new Date(data[i].eveDataFimEvento, 0, 0, 0, 0))
        //     // console.log(moment(datinha).format('YYYY-MM-DD HH:mm:ss'))
        //     data[i].eveDataInicioEvento = moment(datinha).format('YYYY-MM-DD HH:mm:ss')
        //   } else if (datinha.length === 18) {
        //     console.log(new Date(data[i].eveDataFimEvento, 0, 0, 0, 0))
        //     // console.log(moment(datinha2).format('YYYY-MM-DD HH:mm:ss'))
        //     data[i].eveDataInicioEvento = moment(datinha2).format('YYYY-MM-DD HH:mm:ss')
        //   }
        // }

        // if (data[i].eveDataFimEvento.length !== 19) {
        //   const datinha = data[i].eveDataFimEvento + '23:00:00'
        //   const datinha2 = data[i].eveDataFimEvento + ' 23:00:00'
        //   if (datinha.length === 19) {
        //     console.log(new Date(data[i].eveDataFimEvento, 23, 0, 0, 0))
        //     data[i].eveDataFimEvento = moment(datinha).format('YYYY-MM-DD HH:mm:ss')
        //   } else if (datinha.length === 18) {
        //     console.log(new Date(data[i].eveDataFimEvento, 23, 0, 0, 0))
        //     // console.log(moment(datinha2).format('YYYY-MM-DD HH:mm:ss'))
        //     data[i].eveDataFimEvento = moment(datinha2).format('YYYY-MM-DD HH:mm:ss')
        //   }
        // }
      }

      const evento = await dbConnection.model('EveEvento').bulkCreate(data)

      const giros = []
      data.map((eve, index) => {
        const eventoCriado = evento.find((even, index2) => index === index2)
        console.log('EVENTO CRIADO: ', eventoCriado)
        if (eve?.giro && eventoCriado !== undefined) {
          eve?.giro.map(giro => {
            const obj = {
              giroEvento: eventoCriado?.id,
              giroHoraFim: giro.giroHoraFim,
              giroHoraInicio: giro.giroHoraInicio,
              ambientes: giro.ambientes
            }
            giros.push(obj)
          })
        }
      })

      const giroMesa = await dbConnection.model('GiroMesa').bulkCreate(giros)
      const setores = []
      data.map((eve, index) => {
        const eventoCriado = evento.find((even, index2) => index === index2)
        console.log('EVENTO CRIADO SETOR: ', eventoCriado)
        if (eve.setores.length > 0 && eventoCriado !== undefined) {
          eve.setores.map(set => {
            setores.push({
              id_evento: eventoCriado.id,
              titulo: set.titulo
            })
          })
        }
      })
      await dbConnection.model('EventoEsperaSetores').bulkCreate(setores)

      let ambientesCriados = []
      if (data[0].eveCenarioMesas === null || data[0].eveCenarioMesas === undefined) {
        const ambientes = []
        if (giroMesa.length > 0) {
          // giroMesa.map(giroCriado => {
          //   giros.map(giro => {
          //     if (giroCriado.giroHoraInicio === giro.giroHoraInicio) {
          //       giro.ambientes.map(amb => {
          //         const obj = {
          //           id_giro: giroCriado.id,
          //           nome: amb.nomeDoAmbiente,
          //           limiteReservas: amb.limiteDeReservas,
          //           limitePessoas: amb.limiteDePessoas,
          //           limitePessoasReserva: amb.limiteDePessoasPorReservas
          //         }
          //         ambientes.push(obj)
          //       })
          //     }
          //   })
          // })

          const ambientesCriados = new Set()

          giroMesa.map(giroCriado => {
            giros.map((giro, indexGiro) => {
              if (giroCriado.giroHoraInicio === giro.giroHoraInicio) {
                giro.ambientes.map(amb => {
                  if (amb.giroIndex === indexGiro) {
                    const obj = {
                      id_giro: giroCriado.id,
                      nome: amb.nomeDoAmbiente,
                      limiteReservas: amb.limiteDeReservas,
                      limitePessoas: amb.limiteDePessoas,
                      limitePessoasReserva: amb.limiteDePessoasPorReservas
                    }
                    if (!ambientesCriados.has(obj)) {
                      ambientes.push(obj)
                      ambientesCriados.add(obj)
                    }
                  }
                })
              }
            })
          })
        }

        ambientesCriados = await dbConnection.model('EveReservaAmbiente').bulkCreate(ambientes)
      }

      const newEventos = evento.map(eve => ({
        ...eve.dataValues,
        GiroMesa: giroMesa.filter(giro => giro.dataValues.giroEvento === eve.dataValues.id).map(giro => ({
          ...giro.dataValues,
          EveReservaAmbientes: ambientesCriados.filter(ambiente => ambiente.dataValues.id_giro === giro.dataValues.id)
        })),
        // GiroMesas: giroComInclude.length > 0 ? giroComInclude : giroMesa,
        EveLista: [],
        eveAniversarios: [],
        eveFlyer: null,
        eveColaboradors: []
      }))

      return this.handlerSuccess(newEventos)
    } catch (error) {
      console.log('🚀 ~ file: InsertEventos.js ~ line 21 ~ InsertEventos ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const insertEventos = new InsertEventos()

module.exports = insertEventos.main.bind(insertEventos)
