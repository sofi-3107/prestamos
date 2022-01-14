'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Usuario extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
     Usuario.hasMany(models.Prestamos,{foreignKey:'fk_prestamos'});
    }
  };
  Usuario.init({
    nombre: DataTypes.STRING(20),
    apellido: DataTypes.STRING(20),
    curso: DataTypes.STRING(6),
    dni: DataTypes.STRING(8),
    telefono: DataTypes.STRING(20),
    observaciones: DataTypes.STRING(100)
  }, {
    sequelize,
    modelName: 'Usuario',
  });
  return Usuario;
};