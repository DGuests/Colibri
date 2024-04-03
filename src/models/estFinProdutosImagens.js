module.exports = function (sequelize, DataTypes) {
  var produtos = sequelize.define('estFinProdutosImagens', {
    id: {
      field: 'p_prd_id',
      type: DataTypes.INTEGER.UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      unique: {
        args: true,
        msg: 'Este id já está em uso!'
      },
      allowNull: false
    },
    url: {
      field: 's_prd_titulo',
      type: DataTypes.STRING(120),
      allowNull: false
    },
    id_produto: {
      field: 'f_prd_grupo',
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: false
    },
  }, {
    sequelize,
    modelName: 'estFinProdutosImagens',
    freezeTableName: true,
    tableName: 'tb_est_fin_produtos_imagens',
    paranoid: true
  })

  produtos.associate = function (models) {
    produtos.belongsTo(models.estFinProdutos, { foreignKey: 'id_produto', targetKey: 'id' })
  }

  return produtos
}
