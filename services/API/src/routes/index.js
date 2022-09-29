const apiRoutes = require('./api');
const usersRoutes = require('./usuarios');
const userRoutes = require('./Usuario');
const newsRoutes = require('./Anuncio');
const courseRoutes = require('./Curso');

module.exports = (app) => {
    apiRoutes(app);
    usersRoutes(app);
    userRoutes(app);
    newsRoutes(app);
    courseRoutes(app);
};
