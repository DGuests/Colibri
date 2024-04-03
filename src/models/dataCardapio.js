module.exports = (sequelize, DataTypes) => {
    const dataCardapio = sequelize.define('DataCardapio', {
      id: {
        field: 'p_car_id',
        type: DataTypes.INTEGER,
        autoIncrement: true,
        allowNull: false,
        primaryKey: true
      },
      estabelecimento: {
        field: 'f_car_estabelecimento',
        type: DataTypes.INTEGER,
        allowNull: false
      },
      entradas: {
        field: 'n_car_entradas',
        type: DataTypes.INTEGER,
        allowNull: false
      },
      data: {
        field: 't_car_data',
        type: DataTypes.DATE,
        allowNull: false
      }
    }, {
      sequelize,
      modelName: 'DataCardapio',
      freezeTableName: true,
      tableName: 'tb_data_cardapio'
    })

     // cidades.associate = function (models) {
    //     cidades.belongsTo(models.bnfBeneficio, { foreignKey: 'bnfId', targetKey: 'id' })
    // }; 
    //falta criar a associação
  
    return dataCardapio;
  }
  