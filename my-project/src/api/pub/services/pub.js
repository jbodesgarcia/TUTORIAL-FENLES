'use strict';

const { createCoreService } = require('@strapi/strapi').factories;

// @ts-ignore
module.exports = createCoreService('api::pub.pub', ({ strapi }) => ({

  async getAffordablePubs(maxPrice = 15) {
    return await strapi.entityService.findMany('api::pub.pub', {
      filters: { avgPrice: { $lte: maxPrice } },
      populate: '*',
    });
  },

}));