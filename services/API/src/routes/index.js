const apiRoutes = require('./api');
const userRoutes = require('./Usuario');
// const userRoutes = require('./usuarios');
const courseRoutes = require('./Curso');
const newsRoutes = require('./Anuncio');

module.exports = (app) => {
    apiRoutes(app);
    userRoutes(app);
    courseRoutes(app);
    newsRoutes(app);
};
