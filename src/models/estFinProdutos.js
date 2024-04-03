module.exports = function (sequelize, DataTypes) {
  var produtos = sequelize.define('estFinProdutos', {
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
    titulo: {
      field: 's_prd_titulo',
      type: DataTypes.STRING(120),
      allowNull: false
    },
    detalhe: {
      field: 's_prd_detalhe',
      type: DataTypes.STRING,
      allowNull: true
    },
    cor: {
      field: 's_prd_cor',
      type: DataTypes.STRING(15),
      allowNull: true
    },
    id_categoria: {
      field: 'f_prd_categoria',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    preco: {
      field: 'n_prd_preco',
      type: DataTypes.FLOAT,
      allowNull: false
    },
    preco_promo: {
      field: 'n_prd_preco_promo',
      type: DataTypes.FLOAT,
      allowNull: true
    },
    tipo: {
      field: 's_prd_tipo',
      type: DataTypes.STRING(15),
      allowNull: true
    },
    foto: {
      field: 's_prd_foto',
      type: DataTypes.STRING,
      allowNull: true
    },
    visivel: {
      field: 'b_prd_visivel',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true
    },
    ordem: {
      field: 'n_prd_ordem',
      type: DataTypes.INTEGER,
      allowNull: true
    },
    ordemDestaque: {
      field: 'n_prd_ordem_destaque',
      type: DataTypes.INTEGER,
      allowNull: true
    },
    qtd_subitens: {
      field: 'n_prd_qtd_subitens',
      type: DataTypes.INTEGER,
      allowNull: true
    },
    subitens_extra: {
      field: 'b_prd_subitens_extra',
      type: DataTypes.BOOLEAN,
      // allowNull: false,
      defaultValue: false
    },
    id_grupo: {
      field: 'f_prd_grupo',
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: false
    },
    vegetariano: {
      field: 'b_prd_vegetariano',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    vegano: {
      field: 'b_prd_vegano',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    gluten: {
      field: 'b_prd_gluten',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    lactose: {
      field: 'b_prd_lactose',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    comLactose: {
      field: 'b_prd_com_lactose',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    alcool: {
      field: 'b_prd_alcool',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    ovo: {
      field: 'b_prd_ovo',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    soja: {
      field: 'b_prd_soja',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    peixe: {
      field: 'b_prd_peixe',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    crustaceos: {
      field: 'b_prd_crustaceos',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    amendoas: {
      field: 'b_prd_amendoas',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    leite: {
      field: 'b_prd_leite',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    castanhas: {
      field: 'b_prd_castanhas',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    corantes: {
      field: 'b_prd_corantes',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    comGluten: {
      field: 'b_prd_corantes',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    qtd_pessoas: {
      field: 'n_prd_qtd_pessoas',
      type: DataTypes.INTEGER,
      allowNull: true
    },
    tipo_cardapio: {
      field: 's_prd_tipo_cardapio',
      type: DataTypes.ENUM('a', 'd', 'c'),
      allowNull: true,
      defaultValue: 'a'
    },
    ocultar_preco: {
      field: 'b_prd_ocultar_preco',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    destaque: {
      field: 'b_prd_destaque',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },
    pais: {
      field: 's_prd_pais',
      type: DataTypes.STRING
    }
  }, {
    sequelize,
    modelName: 'estFinProdutos',
    freezeTableName: true,
    tableName: 'tb_est_fin_produtos',
    paranoid: true
  })

  produtos.associate = function (models) {
    produtos.belongsTo(models.EstFinCategoria, { foreignKey: 'id_categoria', targetKey: 'id' })
    produtos.belongsTo(models.EstFinCategoriaGrupo, { foreignKey: 'id_grupo', targetKey: 'id' })
    produtos.hasMany(models.EstFinComplemento, { foreignKey: 'id_produto', sourceKey: 'id' })
    produtos.hasMany(models.estFinProdutosPrecos, { foreignKey: 'id_produto', sourceKey: 'id' })
    produtos.hasOne(models.estFinProdutosTraducao, { foreignKey: 'id_produto', sourceKey: 'id' })
    produtos.hasMany(models.estFinProdutosImagens, { foreignKey: 'id_produto', sourceKey: 'id' })
  }
  // produtos.associate = function (models) {
  //   produtos.belongsTo(models.EstFinCategoria, { foreignKey: 'id_categoria', targetKey: 'id' })
  //   produtos.belongsTo(models.EstFinCategoriaGrupo, { foreignKey: 'id_grupo', targetKey: 'id' })
  //   produtos.hasMany(models.estFinProdutosPrecos, { foreignKey: 'id_produto', sourceKey: 'id' })
  // }

  return produtos
}
