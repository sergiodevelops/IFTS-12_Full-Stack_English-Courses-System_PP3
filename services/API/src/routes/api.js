module.exports = (app) => {
    let router = require("express").Router();
    // simple route "/" response
    app.get('/', (req, res) => res.status(200).send({
        message: 'Welcome to API RRHH Group!, uri "/" route its OK',
    }));
    // simple route "/api" response
    app.get('/api', (req, res) => res.status(200).send({
        message: 'Welcome to API RRHH Group!, uri "/api" route its OK',
    }));

    app.use('/', router);
};
