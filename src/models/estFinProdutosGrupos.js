module.exports = function (sequelize, DataTypes) {
  var produtoGrupo = sequelize.define('estFinProdutosGrupos', {
    id: {
      field: 'p_prd_grp_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      unique: {
        args: true,
        msg: 'Este id já está em uso!'
      },
      allowNull: false
    },
    id_produto: {
      field: 'f_prd_grp_produto',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    titulo: {
      field: 's_prd_grp_titulo',
      type: DataTypes.STRING(100),
      allowNull: false
    },
    obrigatorio: {
      field: 'b_prd_grp_obrigatorio',
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    obrigatorio_qtd: {
      field: 'b_prd_grp_obrigatorio_qtd',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    ordem: {
      field: 'n_prd_grp_ordem',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    qtd_subitens_gratis: {
      field: 'n_prd_qtd_subitens_gratis',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    add_extra: {
      field: '´b_prd_grp_add_extra',
      type: DataTypes.BOOLEAN,
      allowNull: true,
      defaultValue: false
    }
  }, {
    sequelize,
    modelName: 'estFinProdutosGrupos',
    freezeTableName: true,
    tableName: 'tb_est_fin_produtos_grupos'
  })
  return produtoGrupo
}
