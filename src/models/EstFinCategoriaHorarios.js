'use strict'

module.exports = function (sequelize, DataTypes) {
  var estFinCategoriaHorarios = sequelize.define('EstFinCategoriaHorario', {
    id: {
      field: 'p_hora_id',
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false
    },
    id_categoria: {
      field: 'f_hora_categoria',
      type: DataTypes.INTEGER,
      foreignKey: true,
      allowNull: false
    },
    inicioSegunda: {
      field: 't_hora_inicio_seg',
      type: DataTypes.TIME
    },
    fimSegunda: {
      field: 't_hora_fim_seg',
      type: DataTypes.TIME
    },
    inicioTerca: {
      field: 't_hora_inicio_ter',
      type: DataTypes.TIME
    },
    fimTerca: {
      field: 't_hora_fim_ter',
      type: DataTypes.TIME
    },
    inicioQuarta: {
      field: 't_hora_inicio_qua',
      type: DataTypes.TIME
    },
    fimQuarta: {
      field: 't_hora_fim_qua',
      type: DataTypes.TIME
    },
    inicioQuinta: {
      field: 't_hora_inicio_qui',
      type: DataTypes.TIME
    },
    fimQuinta: {
      field: 't_hora_fim_qui',
      type: DataTypes.TIME
    },
    inicioSexta: {
      field: 't_hora_inicio_sex',
      type: DataTypes.TIME
    },
    fimSexta: {
      field: 't_hora_fim_sex',
      type: DataTypes.TIME
    },
    inicioSabado: {
      field: 't_hora_inicio_sab',
      type: DataTypes.TIME
    },
    fimSabado: {
      field: 't_hora_fim_sab',
      type: DataTypes.TIME
    },
    inicioDomingo: {
      field: 't_hora_inicio_dom',
      type: DataTypes.TIME
    },
    fimDomingo: {
      field: 't_hora_fim_dom',
      type: DataTypes.TIME
    }
  }, {
    sequelize,
    modelName: 'EstFinCategoriaHorario',
    freezeTableName: true,
    tableName: 'tb_est_fin_categoria_horarios'
  })

  estFinCategoriaHorarios.associate = function (models) {
    estFinCategoriaHorarios.belongsTo(models.EstFinCategoria, { foreignKey: 'id_categoria', targetKey: 'id' })
  }
  return estFinCategoriaHorarios
}
