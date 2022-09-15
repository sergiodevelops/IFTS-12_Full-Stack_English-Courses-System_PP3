module.exports = (app) => {
    const CursoController = require("../controllers/Curso");
    const router = require("express").Router();

    router.post("/create", CursoController.create);
    router.get("/", CursoController.findAllByFilters);
    router.put("/", CursoController.replace);
    router.delete("/", CursoController.delete);

    app.use('/api/courses', router);
};
