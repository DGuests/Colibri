'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinMesasHistorico = sequelize.define('EstFinMesaHistorico', {
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
    mesaValor: {
      field: 'n_mesa_valor',
      type: DataTypes.FLOAT
    },
    mesaValorServico: {
      field: 'n_mesa_valor_servico',
      type: DataTypes.FLOAT
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
    },
    status: {
      field: 's_mesa_status',
      type: DataTypes.ENUM('active', 'deleted', 'closed'),
      allowNull: false,
      defaultValue: 'active'
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
    }
  }, {
    sequelize,
    modelName: 'EstFinMesaHistorico',
    freezeTableName: true,
    tableName: 'tb_est_fin_mesas_historico'
  })
  return estFinMesasHistorico
}
