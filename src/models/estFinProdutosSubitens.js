module.exports = function (sequelize, DataTypes) {
  var produtoSubitem = sequelize.define('estFinProdutoSubItens', {
    id: {
      field: 'p_prd_sub_id',
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
      field: 'f_prd_sub_produto',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    id_subitem: {
      field: 'f_prd_sub_subitem',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    ordem: {
      field: 'n_prd_sub_ordem',
      type: DataTypes.INTEGER
    },
    id_grupo: {
      field: 'f_prd_sub_grupo',
      type: DataTypes.INTEGER
    }
  }, {
    sequelize,
    modelName: 'estFinProdutoSubItens',
    freezeTableName: true,
    tableName: 'tb_est_fin_produtos_subitens'
  })
  return produtoSubitem
}
