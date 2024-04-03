'use strict'

module.exports = function (sequelize, DataTypes) {
  var usuCardapioCliente = sequelize.define('UsuCardapioCliente', {
    id: {
      field: '`p_cli_id`',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_estabelecimento: {
      field: '`f_cli_estabelecimento`',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    nome: {
      field: '`s_cli_nome`',
      type: DataTypes.STRING
    },
    telefone: {
      field: '`s_cli_telefone`',
      type: DataTypes.STRING(55)
    },
    cliEmail: {
      field: '`s_cli_email`',
      type: DataTypes.STRING(55)
    },
    clienteEndereco: {
      field: '`s_cli_endereco`',
      type: DataTypes.STRING(500)
    },
    cliPedido: {
      field: '`s_cli_pedido`',
      type: DataTypes.STRING
    },
    dataNascimento: {
      field: '`t_cli_nascimento`',
      type: DataTypes.DATE
    },
    cliSexo: {
      field: '`e_cli_sexo`',
      type: DataTypes.STRING
    },
    cliImpresso: {
      field: '`b_cli_impresso`',
      type: DataTypes.BOOLEAN,
      defaultValues: false,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'UsuCardapioCliente',
    freezeTableName: true,
    tableName: 'tb_usu_cardapio_clientes',
    paranoid: true
  })

  usuCardapioCliente.associate = function (models) {
    // usuCardapioCliente.hasMany(models.PrmPosVenda, { foreignKey: 'id_cardapio', sourceKey: 'id' })
    usuCardapioCliente.belongsTo(models.EveEvento, { foreignKey: 'id_estabelecimento', targetKey: 'eveUsuario' })
  }
  return usuCardapioCliente
}
