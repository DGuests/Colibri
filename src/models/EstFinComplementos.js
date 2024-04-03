'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinComplementos = sequelize.define('EstFinComplemento', {
    id: {
      field: 'p_comp_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_produto: {
      field: 'f_prod_id',
      type: DataTypes.INTEGER,
      foreignKey: true
    },
    nome: {
      field: 's_comp_nome',
      type: DataTypes.STRING(80)
    },
    obrigatoriedade: {
      field: 'e_comp_obrigatoriedade',
      type: DataTypes.ENUM('OPCIONAL', 'OBRIGATORIO')
    },
    qntMinima: {
      field: 'n_comp_qtd_minima',
      type: DataTypes.INTEGER(3)
    },
    qntMaxima: {
      field: 'n_comp_qtd_maxima',
      type: DataTypes.INTEGER(3)
    }

  }, {
    sequelize,
    modelName: 'EstFinComplemento',
    freezeTableName: true,
    tableName: 'tb_est_fin_complementos',
    paranoid: true
  })

  estFinComplementos.associate = function (models) {
    estFinComplementos.belongsTo(models.estFinProdutos, { foreignKey: 'id_produto', targetKey: 'id' })
    estFinComplementos.hasMany(models.EstFinComplementoItem, { foreignKey: 'id_complemento', sourceKey: 'id' })
  }

  return estFinComplementos
}
