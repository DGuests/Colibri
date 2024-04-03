'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinCategorias = sequelize.define('EstFinCategoria', {
    id: {
      field: 'p_cat_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    titulo: {
      field: 's_cat_titulo',
      type: DataTypes.STRING(255),
      allowNull: false
    },
    cor: {
      field: 's_cat_cor',
      type: DataTypes.STRING(15)
    },
    id_usuario: {
      field: 'f_cat_usuario',
      type: DataTypes.INTEGER,
      foreignKey: true
    },
    icone: {
      field: 's_cat_icone',
      type: DataTypes.STRING(35)
    },
    visivel: {
      field: 'b_cat_visivel',
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    ordem: {
      field: 'n_cat_ordem',
      type: DataTypes.INTEGER
    },
    tipoCardapio: {
      field: 's_cat_tipo_cardapio',
      type: DataTypes.ENUM('A', 'D', 'F'), // Trocar para ENUM onde os valores podem ser "d" para delivery, "a" para ambos e "f" para fisico
      allowNull: false,
      defaultValue: 'A'
    },
    observacao: {
      field: 's_cat_observacao',
      type: DataTypes.TEXT
    },
    preco: {
      field: 'n_cat_preco',
      type: DataTypes.DECIMAL
    },
    cozinha: {
      field: 'f_cat_cozinha',
      type: DataTypes.INTEGER,
      foreignKey: true
    },
    image: {
      field: 's_cat_image',
      type: DataTypes.TEXT
    },

  }, {
    sequelize,
    modelName: 'EstFinCategoria',
    freezeTableName: true,
    tableName: 'tb_est_fin_categoria',
    paranoid: true
  })

  estFinCategorias.associate = function (models) {
    estFinCategorias.belongsTo(models.Users, { foreignKey: 'id_usuario', targetKey: 'id' })
    estFinCategorias.hasMany(models.estFinProdutos, { foreignKey: 'id_categoria', sourceKey: 'id' })
    estFinCategorias.hasMany(models.EstFinCategoriaGrupo, { foreignKey: 'id_categoria', sourceKey: 'id' })
    estFinCategorias.belongsTo(models.EstFinCozinha, { foreignKey: 'cozinha', targetKey: 'id' })
    estFinCategorias.hasOne(models.EstFinCategoriaHorario, { foreignKey: 'id_categoria', sourceKey: 'id' })
    estFinCategorias.hasOne(models.EstFinCategoriaTraducao, { foreignKey: 'id_categoria', sourceKey: 'id' })
  }

  return estFinCategorias
}
