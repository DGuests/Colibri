module.exports = function (sequelize, DataTypes) {
  var produtosPrecos = sequelize.define('estFinProdutosPrecos', {
    id: {
      field: 'p_pre_id',
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
      field: 'f_pre_produto',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    nome: {
      field: 's_pre_nome',
      type: DataTypes.STRING(20),
      allowNull: false
    },
    preco: {
      field: 'n_pre_preco',
      type: DataTypes.FLOAT,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'estFinProdutosPrecos',
    freezeTableName: true,
    tableName: 'tb_est_fin_produto_precos'
  })

  // produtosPrecos.associate = function (models) {
  //   produtosPrecos.belongsTo(models.estFinProdutos, { foreignKey: 'id_produto', targetKey: 'id' })
  // }

  return produtosPrecos
}
