const AnuncioController = require("../controllers/usuarios");
module.exports = (app) => {
    const AnuncioController = require("../controllers/anuncios");
    const router = require("express").Router();

    router.post("/create", AnuncioController.create);
    router.get("/", AnuncioController.findAllByFilters);
    router.put("/", AnuncioController.replace);
    router.delete("/", AnuncioController.delete);

    app.use('/api/jobAds', router);
};
