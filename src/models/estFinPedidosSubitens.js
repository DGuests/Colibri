module.exports = function (sequelize, DataTypes) {
  var pedidoSubitens = sequelize.define('estFinPedidosSubitens', {
    id: {
      field: 'p_ped_sub_id',
      type: DataTypes.INTEGER.UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      unique: {
        args: true,
        msg: 'Este id já está em uso!'
      },
      allowNull: false
    },
    id_pedido: {
      field: 'f_ped_sub_pedido',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    id_subitem: {
      field: 'f_ped_sub_subitem',
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'estFinPedidosSubitens',
    freezeTableName: true,
    tableName: 'tb_est_fin_pedidos_subitens'
  })

  // pedidoSubitens.associate = function (models) {
  //   // pedidoSubitens.belongsTo(models.estFinPedidos, { foreignKey: 'id_pedido', targetKey: 'id' })
  //   pedidoSubitens.belongsTo(models.estFinProdutos, { foreignKey: 'id_subitem', targetKey: 'id' })
  // }

  return pedidoSubitens
}
