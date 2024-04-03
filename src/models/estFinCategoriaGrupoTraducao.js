module.exports = function (sequelize, DataTypes) {
  var gruposTraducao = sequelize.define('EstFinCategoriaGrupoTraducao', {
    id: {
      field: 'p_trad_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_grupo: {
      field: 'f_trad_grupo',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    ingles: {
      field: 's_trad_ingles',
      type: DataTypes.STRING
    },
    espanhol: {
      field: 's_trad_espanhol',
      type: DataTypes.STRING
    }
  }, {
    sequelize,
    modelName: 'EstFinCategoriaGrupoTraducao',
    freezeTableName: true,
    tableName: 'tb_est_fin_categoria_grupos_traducao',
    paranoid: true
  })

  gruposTraducao.associate = function (models) {
    gruposTraducao.belongsTo(models.EstFinCategoriaGrupo, { foreignKey: 'id_grupo', targetKey: 'id' })
  }

  return gruposTraducao
}
