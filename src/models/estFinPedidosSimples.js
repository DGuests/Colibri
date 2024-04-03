module.exports = function (sequelize, DataTypes) {
  var pedidoSimples = sequelize.define('estFinPedidosSimples', {
    id: {
      field: 'p_ped_id',
      type: DataTypes.INTEGER.UNSIGNED,
      primaryKey: true,
      autoIncrement: true,
      unique: {
        args: true,
        msg: 'Este id já está em uso!'
      },
      allowNull: false
    },
    id_estabelecimento: {
      field: 'f_ped_estabelecimento',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    nome: {
      field: 's_ped_nome',
      type: DataTypes.STRING(255),
      allowNull: false
    },
    fone: {
      field: 's_ped_fone',
      type: DataTypes.STRING(25),
      allowNull: false
    },
    email: {
      field: 's_ped_email',
      type: DataTypes.STRING(120),
      allowNull: false
    },
    pager: {
      field: 'n_ped_pager',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    status: {
      field: 's_ped_status',
      type: DataTypes.STRING(1),
      allowNull: false,
      defaultValue: 'a'
    },
    observacao: {
      field: 's_ped_observacao',
      type: DataTypes.STRING(35),
      allowNull: true
    }
  }, {
    sequelize,
    modelName: 'estFinPedidosSimples',
    freezeTableName: true,
    tableName: 'tb_est_fin_pedidos_simples',
    timestamps: false
  })

  // pedidoSimples.associate = function (models) {
  //   pedidoSimples.belongsTo(models.Configuracoes, { foreignKey: 'id_estabelecimento', targetKey: 'id' })
  // }

  return pedidoSimples
}
