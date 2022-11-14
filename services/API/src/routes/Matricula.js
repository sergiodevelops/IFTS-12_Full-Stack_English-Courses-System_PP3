module.exports = (app) => {
    const MatriculaController = require("../controllers/Matricula");
    const router = require("express").Router();

    router.post("/create", MatriculaController.create);
    router.get("/", MatriculaController.findAllByFilters);
    router.put("/", MatriculaController.replace);
    router.delete("/", MatriculaController.delete);

    app.use('/api/matriculas', router);
};
