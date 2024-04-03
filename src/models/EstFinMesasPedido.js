'use strict'

module.exports = function (sequelize, DataTypes) {
  const estFinMesasPedidos = sequelize.define('EstFinMesaPedido', {
    id: {
      field: 'p_mesa_ped_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    mesaId: {
      field: 'f_mesa_id',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    usuarioId: {
      field: 'f_usu_id',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    mesaNumero: {
      field: 's_mesa_numero',
      type: DataTypes.STRING(50),
      allowNull: false
    },
    hash: {
      field: 's_mesa_hash',
      type: DataTypes.STRING,
      allowNull: false
    },
    qdePessoas: {
      field: 'n_mesa_qde_pessoas',
      type: DataTypes.INTEGER
    },
    nota: {
      field: 'n_mesa_nota',
      type: DataTypes.FLOAT
    },
    dataAbertura: {
      field: 'd_mesa_data_abertura',
      type: DataTypes.DATE
    },
    dataFechamento: {
      field: 'd_mesa_data_fechamento',
      type: DataTypes.DATE
    },
    token: {
      field: 's_mesa_token',
      type: DataTypes.STRING
    },
    mesaValor: {
      field: 'n_mesa_valor',
      type: DataTypes.FLOAT
    },
    mesaValorServico: {
      field: 'n_mesa_valor_servico',
      type: DataTypes.FLOAT
    },
    mesaStatus: {
      field: 's_mesa_status',
      type: DataTypes.ENUM('closed', 'active')
    },
    mesaValorCouvert: {
      field: 'n_mesa_valor_couvert',
      type: DataTypes.FLOAT
    },
    mesaValorTotal: {
      field: 'n_mesa_valor_total',
      type: DataTypes.FLOAT
    },
    mesaForma: {
      field: 's_mesa_forma',
      type: DataTypes.STRING(50)
    },
    mesaSituacao: {
      field: 's_mesa_situacao',
      type: DataTypes.STRING(50)
    }
  }, {
    sequelize,
    modelName: 'EstFinMesaPedido',
    freezeTableName: true,
    tableName: 'tb_est_fin_mesas_pedido',
    paranoid: true
  })

  estFinMesasPedidos.associate = function (models) {
    estFinMesasPedidos.hasMany(models.estFinPedidosProdutos, { foreignKey: 'id_cliente', sourceKey: 'id' })

    estFinMesasPedidos.belongsTo(models.EstFinMesa, { foreignKey: 'mesaId', targetKey: 'id' })
  }

  return estFinMesasPedidos
}
