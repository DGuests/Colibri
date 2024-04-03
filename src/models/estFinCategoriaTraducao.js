module.exports = function (sequelize, DataTypes) {
  var gruposTraducao = sequelize.define('EstFinCategoriaTraducao', {
    id: {
      field: 'p_trad_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_categoria: {
      field: 'f_trad_categoria',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    tituloPortugues: {
      field: 's_trad_portugues',
      type: DataTypes.STRING,
      allowNull: false
    },
    tituloIngles: {
      field: 's_trad_ingles',
      type: DataTypes.STRING
    },
    tituloEspanhol: {
      field: 's_trad_espanhol',
      type: DataTypes.STRING
    },
    obsIngles: {
      field: 's_trad_observacao_ingles',
      type: DataTypes.STRING
    },
    obsEspanhol: {
      field: 's_trad_observacao_espanhol',
      type: DataTypes.STRING
    }
  }, {
    sequelize,
    modelName: 'EstFinCategoriaTraducao',
    freezeTableName: true,
    tableName: 'tb_est_fin_categoria_traducao',
    paranoid: true
  })

  gruposTraducao.associate = function (models) {
    gruposTraducao.belongsTo(models.EstFinCategoria, { foreignKey: 'id_categoria', targetKey: 'id' })
  }

  return gruposTraducao
}
