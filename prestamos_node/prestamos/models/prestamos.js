'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Prestamos extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Prestamos.belongsTo(models.Usuario);
      Prestamos.belongsToMany(models.Elemento,{through:'prestamo_elemento'});
    }
  };
  Prestamos.init({
    type:DataTypes.STRING(15),
    hora_pedido: DataTypes.STRING(20),
    hora_devolucion: DataTypes.STRING(20)
  }, {
    sequelize,
    modelName: 'Prestamos',
  });
  return Prestamos;
};