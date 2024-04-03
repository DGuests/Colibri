'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinCozinhas = sequelize.define('EstFinCozinha', {
    id: {
      field: 'p_coz_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_estabelecimento: {
      field: 'f_coz_estabelecimento',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    nome: {
      field: 's_coz_nome',
      type: DataTypes.STRING(55),
      allowNull: false
    },
    ativo: {
      field: 'b_coz_ativo',
      type: DataTypes.BOOLEAN
    }
  }, {
    sequelize,
    modelName: 'EstFinCozinha',
    freezeTableName: true,
    tableName: 'tb_est_fin_cozinhas',
    paranoid: true
  })

  estFinCozinhas.associate = function (models) {
    estFinCozinhas.belongsTo(models.ocEstabelecimento, { foreignKey: 'id_estabelecimento', targetKey: 'id' })
    estFinCozinhas.hasMany(models.EstFinCategoria, { foreignKey: 'cozinha', sourceKey: 'id' })
    estFinCozinhas.hasMany(models.estFinPedidosProdutos, { foreignKey: 'id_cozinha', sourceKey: 'id' })
  }

  return estFinCozinhas
}
