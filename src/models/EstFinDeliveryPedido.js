'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinDeliveryPedidos = sequelize.define('EstFinDeliveryPedido', {
    id: {
      field: 'p_del_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    usuario: {
      field: 'f_del_usuario',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    cliente: {
      field: 'f_del_cliente',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    valor: {
      field: 'n_del_valor',
      type: DataTypes.FLOAT
    },
    valorEntrega: {
      field: 'n_del_valor_entrega',
      type: DataTypes.FLOAT
    },
    status: {
      field: 's_del_status',
      type: DataTypes.STRING(55),
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'EstFinDeliveryPedido',
    freezeTableName: true,
    tableName: 'tb_est_fin_delivery_pedido'
  })
  return estFinDeliveryPedidos
}
