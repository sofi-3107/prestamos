'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Elementos',[{
      nombre:'netbook',
      descripcion:'BANGHO SUMA II',
      num_serie:'AA203698745',
      codigo_id:'A20',
      estado:'MUY BUENO'
    }]);
  },

  down: async (queryInterface, Sequelize) => {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
