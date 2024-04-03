module.exports = function (sequelize, DataTypes) {
  var produtos = sequelize.define('estFinProdutosTraducao', {
    id: {
      field: 'p_trad_id',
      type: DataTypes.INTEGER.UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      unique: {
        args: true,
        msg: 'Este id já está em uso!'
      },
      allowNull: false
    },
    id_produto: {
      field: 'f_trad_produto',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    tituloIngles: {
      field: 's_trad_titulo_ingles',
      type: DataTypes.STRING(120)
    },
    descricaoIngles: {
      field: 's_trad_descricao_ingles',
      type: DataTypes.STRING(120)
    },
    tituloEspanhol: {
      field: 's_trad_titulo_espanhol',
      type: DataTypes.STRING(120)
    },
    descricaoEspanhol: {
      field: 's_trad_descricao_espanhol',
      type: DataTypes.STRING(120)
    }
  }, {
    sequelize,
    modelName: 'estFinProdutosTraducao',
    freezeTableName: true,
    tableName: 'tb_est_fin_produtos_traducao',
    paranoid: true
  })

  produtos.associate = function (models) {
    produtos.belongsTo(models.estFinProdutos, { foreignKey: 'id_produto', targetKey: 'id' })
  }

  return produtos
}
