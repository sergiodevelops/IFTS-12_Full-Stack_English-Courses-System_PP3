module.exports = (app) => {
    const AulaController = require("../controllers/Aula");
    const router = require("express").Router();

    // router.post("/create", AulaController.create);
    router.get("/", AulaController.findAllByFilters);
    // router.put("/", AulaController.replace);
    // router.delete("/", AulaController.delete);

    app.use('/api/classrooms', router);
};
