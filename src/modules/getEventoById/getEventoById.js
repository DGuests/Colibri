'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const Sequelize = require('sequelize')
const connection = require('@src/models')
// const { userAttributesPick } = require('@src/utils')
const { obterIdUsuario } = require('../../utils/index')

class GetEventoById extends BaseHandlerLambda {
  async main (event) {
    console.log('🚀 ~ file: GetEventoById.js ~ line 10 ~ GetEventoById ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: { idCognito: idUser }
      })

      if (user.id !== undefined || user.id !== null) {
        if (event.queryStringParameters !== null) {
          var qtd = event.queryStringParameters.qtd

          var array = []
          await dbConnection.model('GiroMesa').findAll({
            where: {
              giroEvento: event.pathParameters.id
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

          const eventoById = await dbConnection.model('EveEvento').findOne({
            where: {
              id: event.pathParameters.id
            },
            attributes: ['id', 'eveTitulo', 'eveDescricao'],
            include: [
              {
                model: dbConnection.model('PrmCenarioMesa'),
                attributes: ['id'],
                required: false,
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
                    include: [
                      {
                        model: dbConnection.model('PrmReservaMesa'),
                        required: true,
                        where: {
                          [Sequelize.Op.or]: [
                            {
                              reservaHorario: array[0].map((giro) => giro)
                            },
                            {
                              reservaHorario: null
                            }
                          ]
                        },
                        include: [
                          { model: dbConnection.model('GiroMesa') }
                        ]
                      }
                    ]
                  }
                ]
              },
              { model: dbConnection.model('GiroMesa') }
            ]
          })
          return this.handlerSuccess(eventoById)
        } else {
          const eventoById = await dbConnection.model('EveEvento').findOne({
            where: {
              id: event.pathParameters.id
            }
          })
          return this.handlerSuccess(eventoById)
        }
      }
    } catch (error) {
      console.log('🚀 ~ file: GetEventoById.js ~ line 20 ~ GetEventoById ~ main ~ error', error)
      return this.handleError(error)
    }
  }
}

const getEventoById = new GetEventoById()

module.exports = getEventoById.main.bind(getEventoById)
