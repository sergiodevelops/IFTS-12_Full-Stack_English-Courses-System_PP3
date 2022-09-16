module.exports = (app) => {
    const AnuncioController = require("../controllers/Anuncio");
    const router = require("express").Router();

    router.post("/create", AnuncioController.create);
    router.get("/", AnuncioController.findAllByFilters);
    router.put("/", AnuncioController.replace);
    router.delete("/", AnuncioController.delete);

    app.use('/api/news', router);
};
