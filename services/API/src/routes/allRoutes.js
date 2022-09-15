const generalRoutes = require('../routes/api');
const userRoutes = require('../routes/usuarios');
// const applicantsRoutes = require('../routes/postulantes');
// const jobAdsRoutes = require('../routes/anuncios');
const courseRoutes = require('../routes/Curso');

module.exports = (app) => {
    generalRoutes(app);
    userRoutes(app);
    // applicantsRoutes(app);
    // jobAdsRoutes(app);
    courseRoutes(app);
};
