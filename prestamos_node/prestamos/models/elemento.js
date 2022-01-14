'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Elemento extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Elemento.hasMany(models.Prestamos);
    }
  };
  Elemento.init({
    nombre: DataTypes.STRING(20),
    descripcion: DataTypes.STRING(50),
    num_serie: DataTypes.STRING(20),
    codigo_id: DataTypes.STRING(3),
    cod_inventario: DataTypes.STRING(20),
    estado: DataTypes.ENUM('NUEVO','MUY BUENO','BUENO','REGULAR','MALO','BAJA'),
    observaciones: DataTypes.STRING(100),
    imagen: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Elemento',
    timestamps:false
  });
  return Elemento;
};