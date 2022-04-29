'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.addColumn('Elementos','imagen',Sequelize.STRING);
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('Elementos','imagen');
  }
};
