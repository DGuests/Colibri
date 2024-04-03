module.exports = function (sequelize, DataTypes) {
  const pedidoProdutos = sequelize.define('estFinPedidosProdutos', {
    id: {
      field: 'p_ped_id',
      type: DataTypes.INTEGER.UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      unique: {
        args: true,
        msg: 'Este id já está em uso!'
      },
      allowNull: false
    },
    id_cliente: {
      field: 'f_ped_cliente',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    id_produto: {
      field: 'f_ped_produto',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    id_estabelecimento: {
      field: 'f_ped_id',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    observacao: {
      field: 's_ped_observacao',
      type: DataTypes.STRING(500),
      allowNull: true
    },
    status: {
      field: 's_ped_status',
      type: DataTypes.STRING(15),
      allowNull: false,
      defaultValue: 'NOVO'
    },
    id_mesa: {
      field: 'f_ped_mesa',
      type: DataTypes.INTEGER,
      allowNull: true
    },
    qde: {
      field: 'n_ped_qde',
      type: DataTypes.INTEGER,
      allowNull: true
    },
    valor_unitario: {
      field: 'n_ped_valor_unitario',
      type: DataTypes.FLOAT,
      allowNull: true
    },
    valor_total: {
      field: 'n_ped_valor_total',
      type: DataTypes.FLOAT,
      allowNull: true
    },
    produto_nome_original: {
      field: 's_ped_produto_nome_original',
      type: DataTypes.STRING(255),
      allowNull: true
    },
    visivel: {
      field: 'b_ped_visivel',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true
    },
    id_cozinha: {
      field: 'f_ped_cozinha',
      type: DataTypes.INTEGER,
      allowNull: true
    }
  }, {
    sequelize,
    modelName: 'estFinPedidosProdutos',
    freezeTableName: true,
    tableName: 'tb_est_fin_pedidos_produtos',
    paranoid: true
  })

  pedidoProdutos.associate = function (models) {
  //   pedidoProdutos.belongsTo(models.usuCardapioClientes, { foreignKey: 'id_cliente', targetKey: 'id' })
  //   pedidoProdutos.belongsTo(models.estFinProdutos, { foreignKey: 'id_produto', targetKey: 'id' })
    pedidoProdutos.belongsTo(models.Users, { foreignKey: 'id_estabelecimento', targetKey: 'id' })
    pedidoProdutos.belongsTo(models.EstFinMesaPedido, { foreignKey: 'id_cliente', targetKey: 'id' })
    pedidoProdutos.belongsTo(models.EstFinMesa, { foreignKey: 'id_mesa', targetKey: 'id' })
    pedidoProdutos.belongsTo(models.EstFinCozinha, { foreignKey: 'id_cozinha', targetKey: 'id' })
  }

  return pedidoProdutos
}
