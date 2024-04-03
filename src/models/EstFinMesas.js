'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinMesas = sequelize.define('EstFinMesa', {
    id: {
      field: 'p_mesa_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    usuarioId: {
      field: 'f_usu_id',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    numero: {
      field: 's_mesa_numero',
      type: DataTypes.STRING(50),
      allowNull: false
    },
    hash: {
      field: 's_mesa_hash',
      type: DataTypes.STRING
    },
    status: {
      field: 's_mesa_status',
      type: DataTypes.ENUM('active', 'deleted', 'closed'),
      allowNull: false,
      defaultValue: 'closed'
    },
    tipo: {
      field: 'e_mesa_tipo',
      type: DataTypes.ENUM('mesa', 'quarto')
    },
    numero2: {
      field: 's_mesa_numero2',
      type: DataTypes.INTEGER
    }
  }, {
    sequelize,
    modelName: 'EstFinMesa',
    freezeTableName: true,
    tableName: 'tb_est_fin_mesas',
    paranoid: true
  })

  estFinMesas.associate = function (models) {
    estFinMesas.hasMany(models.EstFinMesaPedido, { foreignKey: 'mesaId', sourceKey: 'id' })
    estFinMesas.hasMany(models.estFinPedidosProdutos, { foreignKey: 'id_mesa', sourceKey: 'id' })
  }

  return estFinMesas
}
