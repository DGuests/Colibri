'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinComplementosItens = sequelize.define('EstFinComplementoItem', {
    id: {
      field: 'p_comp_item_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_complemento: {
      field: 'f_comp_id',
      type: DataTypes.INTEGER,
      foreignKey: true
    },
    nome: {
      field: 's_comp_item_nome',
      type: DataTypes.STRING(80)
    },
    descricao: {
      field: 's_comp_item_descricao',
      type: DataTypes.STRING(250)
    },
    preco: {
      field: 'n_comp_item_preco',
      type: DataTypes.FLOAT
    },
    foto: {
      field: 's_comp_item_foto',
      type: DataTypes.STRING(25)
    },
    status: {
      field: 'e_comp_item_status',
      type: DataTypes.ENUM('ATIVADO', 'PAUSADO')
    }

  }, {
    sequelize,
    modelName: 'EstFinComplementoItem',
    freezeTableName: true,
    tableName: 'tb_est_fin_complementos_itens',
    paranoid: true
  })

  estFinComplementosItens.associate = function (models) {
    estFinComplementosItens.belongsTo(models.EstFinComplemento, { foreignKey: 'id_complemento', targetKey: 'id' })
  }
  return estFinComplementosItens
}
