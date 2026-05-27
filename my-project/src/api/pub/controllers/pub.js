'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::pub.pub', ({ strapi }) => ({

  async find(ctx) {
    let result = await strapi.entityService.findMany('api::pub.pub', { populate: '*' });
    return result;
  },

  async affordable(ctx) {
    const maxPrice = ctx.query.maxPrice ? parseInt(ctx.query.maxPrice, 10) : 15;
    const result = await strapi.service('api::pub.pub').getAffordablePubs(maxPrice);
    return result;
  },

}));
