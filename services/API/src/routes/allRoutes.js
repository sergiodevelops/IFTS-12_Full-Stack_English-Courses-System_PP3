const apiRoutes = require('../routes/api');
const userRoutes = require('../routes/usuarios');
const courseRoutes = require('../routes/Curso');
const newsRoutes = require('../routes/Anuncio');

module.exports = (app) => {
    apiRoutes(app);
    userRoutes(app);
    courseRoutes(app);
    newsRoutes(app);
};
