'use strict'

module.exports = function (sequelize, DataTypes) {
  var usuCardapio = sequelize.define('UsoCardapio', {
    id: {
      field: 'p_usu_car_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_usuario: {
      field: 'f_usu_car_usuario',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    wpp: {
      field: 'b_usu_car_wpp',
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
    },
    entrega: {
      field: 'n_usu_car_entrega',
      type: DataTypes.FLOAT
    },
    exigeEntrega: {
      field: 'b_usu_car_exige_entrega',
      type: DataTypes.INTEGER,
      allowNull: false
    },
    permiteRetirar: {
      field: 'b_usu_car_permite_retirar',
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
    },
    telefone: {
      field: 's_usu_car_telefone',
      type: DataTypes.STRING(25)
    },
    dataNascimento: {
      field: 's_usu_car_nascimento',
      type: DataTypes.STRING(25)
    },
    exigeLogin: {
      field: 'b_usu_car_exige_login',
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
    },
    horaInicio: {
      field: 't_usu_car_hora_inicio',
      type: DataTypes.STRING(15)
    },
    horaFim: {
      field: 't_usu_car_hora_fim',
      type: DataTypes.STRING(15)
    },
    wifiRede: {
      field: 's_usu_car_wifi_rede',
      type: DataTypes.STRING(45)
    },
    wifi: {
      field: 's_usu_car_wifi',
      type: DataTypes.STRING(45)
    },
    tipoEstabelecimento: {
      field: 's_usu_car_tipo_estabelecimento',
      type: DataTypes.STRING(1)
    },
    observacao: {
      field: 's_usu_car_observacao',
      type: DataTypes.STRING(500)
    },
    tempoEntrega: {
      field: 'n_usu_car_tempo_entrega',
      type: DataTypes.INTEGER
    },
    corCardapio: {
      field: 's_usu_car_cor_cardapio',
      type: DataTypes.STRING(15),
      allowNull: false
    },
    templateNovo: {
      field: 'b_usu_car_template_novo',
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    avaliacao: {
      field: 'b_usu_car_avaliacao',
      type: DataTypes.BOOLEAN,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'UsoCardapio',
    freezeTableName: true,
    tableName: 'tb_usu_cardapio'
  })

  usuCardapio.associate = function (models) {
    usuCardapio.belongsTo(models.Users, { foreignKey: 'id_usuario', targetKey: 'id' })
  }
  return usuCardapio
}
