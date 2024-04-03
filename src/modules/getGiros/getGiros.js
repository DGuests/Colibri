'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const Sequelize = require('sequelize')
const connection = require('@src/models')
// const { userAttributesPick } = require('@src/utils')
const { obterIdUsuario } = require('../../utils/index')

class GetGiros extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetGiros.js ~ line 8 ~ GetGiros ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        }
      })

      // if (user.id !== undefined || user.id !== null) {
      if (event.queryStringParameters !== null) {
        var qtd = event.queryStringParameters.qtd

        var array = []
        await dbConnection.model('GiroMesa').findAll({
          where: {
            giroEvento: event.pathParameters.idEvento
          },
          include: [
            {
              model: dbConnection.model('EveEvento'),
              attributes: ['id'],
              include: [
                {
                  model: dbConnection.model('PrmCenarioMesa'),
                  attributes: ['id'],
                  include: [
                    {
                      model: dbConnection.model('PrmMesa'),
                      attributes: ['id', 'capacidadeMin', 'capacidadeMax'],

                      where: {

                        [Sequelize.Op.and]: [
                          {
                            capacidadeMin: {
                              [Sequelize.Op.lte]: Number(qtd)
                            }
                          },
                          {
                            capacidadeMax: {
                              [Sequelize.Op.gte]: Number(qtd)
                            }
                          }
                        ]

                      },
                      order: [
                        ['capacidadeMax', 'ASC']
                      ],
                      include: [
                        {
                          model: dbConnection.model('PrmReservaMesa'),
                          // where: {
                          //   reservaHorario: array[0]
                          // },
                          include: [
                            {
                              model: dbConnection.model('GiroMesa'),
                              attributes: ['id', 'giroEvento', 'giroHoraInicio', 'giroHoraFim']
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }).then((response) => array.push(response.map((giro) => giro.dataValues.id)))

        const eventos2 = await dbConnection.model('GiroMesa').findAll({
          where: {
            giroEvento: event.pathParameters.idEvento
          },
          include: [
            {
              model: dbConnection.model('EveEvento'),
              attributes: ['id'],
              include: [
                {
                  model: dbConnection.model('PrmCenarioMesa'),
                  required: false,
                  attributes: ['id'],
                  include: [
                    {
                      model: dbConnection.model('PrmMesa'),
                      required: false,
                      attributes: ['id', 'capacidadeMin', 'capacidadeMax'],

                      where: {

                        [Sequelize.Op.and]: [
                          {
                            capacidadeMin: {
                              [Sequelize.Op.lte]: Number(qtd)
                            }
                          },
                          {
                            capacidadeMax: {
                              [Sequelize.Op.gte]: Number(qtd)
                            }
                          }
                        ]

                      },
                      order: [
                        ['capacidadeMax', 'ASC']
                      ],
                      include: [
                        {
                          model: dbConnection.model('PrmReservaMesa'),
                          required: false,
                          where: {
                            id_evento: event.pathParameters.idEvento
                            // reservaHorario: 1779
                          },
                          include: [
                            {
                              model: dbConnection.model('GiroMesa'),
                              attributes: ['id', 'giroEvento', 'giroHoraInicio', 'giroHoraFim']
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        })

        return this.handlerSuccess(eventos2)
      } else {
        const eventos2 = await dbConnection.model('GiroMesa').findAll({
          where: {
            giroEvento: event.pathParameters.idEvento
          },
          include: [
            {
              model: dbConnection.model('EveEvento')
            }]
        })

        return this.handlerSuccess(eventos2)
      }
      // }
    } catch (error) {
      console.log('🚀 ~ file: GetGiros.js ~ line 21 ~ GetGiros ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getGiros = new GetGiros()

module.exports = getGiros.main.bind(getGiros)
