'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinNotificacoes = sequelize.define('EstFinNotificacao', {
    id: {
      field: 'p_not_id',
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
    mesaNumero: {
      field: 's_mesa_numero',
      type: DataTypes.STRING(50),
      allowNull: false
    },
    mensagem: {
      field: 's_not_mensagem',
      type: DataTypes.TEXT
    },
    notEnviadoEm: {
      field: 's_not_enviado_em',
      type: DataTypes.DATE
    }
  }, {
    sequelize,
    paranoide: true,
    modelName: 'EstFinNotificacao',
    freezeTableName: true,
    tableName: 'tb_est_fin_notificacoes'
  })
  return estFinNotificacoes
}
