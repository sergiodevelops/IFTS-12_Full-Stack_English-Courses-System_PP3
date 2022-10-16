module.exports = (app) => {
    let router = require("express").Router();
    // simple route "/" response
    app.get('/', (req, res) => res.status(200).send({
        message: 'Welcome to API Web Site Instituto Idiomas 2022!, uri "/" route its OK',
    }));
    // simple route "/api" response
    app.get('/api', (req, res) => res.status(200).send({
        message: 'Welcome to API Web Site Instituto Idiomas 2022!, uri "/api" route its OK',
    }));

    app.use('/', router);
};
