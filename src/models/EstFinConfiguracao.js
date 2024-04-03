'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinConfiguracoes = sequelize.define('EstFinConfiguracao', {
    id: {
      field: 'p_conf_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_usuario: {
      field: 'f_conf_usuario',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    exigirDados: {
      field: 'b_conf_exigir_dados',
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    taxaServico: {
      field: 'n_conf_taxa_servico',
      type: DataTypes.FLOAT
    },
    exigirToken: {
      field: 'b_conf_exigir_token',
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    valoresPedido: {
      field: 'b_conf_valores_pedido',
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    couvert: {
      field: 'n_conf_couvert',
      type: DataTypes.FLOAT
    }
  }, {
    sequelize,
    modelName: 'EstFinConfiguracao',
    freezeTableName: true,
    tableName: 'tb_est_fin_configuracao',
    paranoid: true
  })

  estFinConfiguracoes.associate = function (models) {
    estFinConfiguracoes.belongsTo(models.Users, { foreignKey: 'id_usuario', targetKey: 'id' })
  }

  return estFinConfiguracoes
}
