const fs = require('fs')
const path = require('path')
const { Sequelize, DataTypes } = require('sequelize')

let sequelize = null

const loadConnection = async () => {
  const sequelizePool = new Sequelize(
    process.env.DB_DBNAME,
    process.env.DB_USERNAME,
    process.env.DB_PASSWORD,
    {
      host: process.env.DB_HOST,
      port: Number(process.env.DB_PORT),
      dialect: 'mysql',
      pool: {
        max: 5,
        min: 0,
        idle: 0,
        acquire: 3000,
        evict: 900000
      }
    }
  )

  // await sequelizePool.sync()
  return sequelizePool
}

module.exports = async () => {
  // re-use the sequelize instance across invocations to improve performance
  if (!sequelize) {
    sequelize = await loadConnection()
    fs
      .readdirSync(__dirname)
      .filter((file) => (file.indexOf('.') !== 0 && (file !== 'index.js') && (file.slice(-3) === '.js')))
      .forEach((file) => {
        const model = require(`${path.join(__dirname, file)}`)(sequelize, DataTypes)
        sequelize.models[model.name] = model
      })
    Object.keys(sequelize.models).forEach(modelName => {
      if (sequelize.models[modelName].associate) {
        sequelize.models[modelName].associate(sequelize.models)
      }
    })
  } else {
    // restart connection pool to ensure connections are not re-used across invocations
    sequelize.connectionManager.initPools()

    // restore `getConnection()` if it has been overwritten by `close()`
    if (Reflect.has(sequelize.connectionManager, 'getConnection')) {
      delete sequelize.connectionManager.getConnection
    }
  }
  // await sequelize.sync()
  return sequelize
}
