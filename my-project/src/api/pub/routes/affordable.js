'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/pubs/affordable',
      handler: 'pub.affordable',
      config: { auth: false },
    },
  ],
};