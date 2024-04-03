'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinPedidos = sequelize.define('EstFinPedido', {
    id: {
      field: 'p_ped_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_cliente: {
      field: 'f_ped_cliente',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    id_produto: {
      field: 'f_ped_cliente',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    observacao: {
      field: 's_ped_observacao',
      type: DataTypes.STRING(500)
    },
    status: {
      field: 's_ped_status',
      type: DataTypes.ENUM('A'),
      allowNull: false
    },
    id_mesa: {
      field: 'f_ped_mesa',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'EstFinPedido',
    freezeTableName: true,
    tableName: 'tb_est_fin_pedidos',
    paranoid: true
  })
  return estFinPedidos
}
