const apiRoutes = require('./api');
const userRoutes = require('./usuarios');
const newsRoutes = require('./Anuncio');
// const courseRoutes = require('./Curso');

module.exports = (app) => {
    apiRoutes(app);
    userRoutes(app);
    newsRoutes(app);
    // courseRoutes(app);
};
