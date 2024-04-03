'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinCategoriaGrupos = sequelize.define('EstFinCategoriaGrupo', {
    id: {
      field: 'p_grp_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_categoria: {
      field: 'f_grp_categoria',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    titulo: {
      field: 's_grp_titulo',
      type: DataTypes.STRING,
      allowNull: false
    },

    ordem: {
      field: 'n_grp_ordem',
      type: DataTypes.INTEGER
    }

  }, {
    sequelize,
    modelName: 'EstFinCategoriaGrupo',
    freezeTableName: true,
    tableName: 'tb_est_fin_categoria_grupos',
    paranoid: true
  })

  estFinCategoriaGrupos.associate = function (models) {
    estFinCategoriaGrupos.belongsTo(models.EstFinCategoria, { foreignKey: 'id_categoria', targetKey: 'id' })
    estFinCategoriaGrupos.hasMany(models.estFinProdutos, { foreignKey: 'id_grupo', sourceKey: 'id' })
    estFinCategoriaGrupos.hasOne(models.EstFinCategoriaGrupoTraducao, { foreignKey: 'id_grupo', sourceKey: 'id' })
  }

  return estFinCategoriaGrupos
}
