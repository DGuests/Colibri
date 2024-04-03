'use strict'

module.exports = function (sequelize, DataTypes) {
  var pedidoImpressao = sequelize.define('estFinPedidosImpressao', {
    id: {
      field: 'p_imp_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_usuario: {
      field: 'f_imp_usuario',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    id_pedido: {
      field: 'f_imp_pedido',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    texto: {
      field: 's_imp_texto',
      type: DataTypes.STRING,
      allowNull: false
    },
    impresso: {
      field: 'b_imp_impresso',
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'estFinPedidosImpressao',
    freezeTableName: true,
    tableName: 'tb_est_fin_pedidos_impressao'
  })

  // pedidoImpressao.associate = function (models) {
  //   pedidoImpressao.belongsTo(models.Users, { foreignKey: 'id_usuario', targetKey: 'id' })
  //   // pedidoImpressao.belongsTo(models.estFinPedidos, { foreignKey: 'id_pedido', targetKey: 'id' })
  // }

  return pedidoImpressao
}
