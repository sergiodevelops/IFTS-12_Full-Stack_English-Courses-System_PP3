const generalRoutes = require('../routes/api');
const userRoutes = require('../routes/Usuario').default;
const personRoutes = require('../routes/Persona');
// const applicantsRoutes = require('../routes/postulantes');
// const jobAdsRoutes = require('../routes/anuncios');
const courseRoutes = require('../routes/Curso');

module.exports = (app) => {
    generalRoutes(app);
    userRoutes(app);
    personRoutes(app);
    // applicantsRoutes(app);
    // jobAdsRoutes(app);
    courseRoutes(app);
};
