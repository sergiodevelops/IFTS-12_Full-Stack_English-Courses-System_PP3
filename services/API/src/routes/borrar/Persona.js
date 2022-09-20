module.exports = (app) => {
    const PersonaController = require("../controllers/Persona");
    const router = require("express").Router();

    router.post("/create", PersonaController.create);
    // router.get("/", PersonaController.findAllByFilters);
    // router.put("/", PersonaController.replace);
    // router.delete("/", PersonaController.delete);

    app.use('/api/applicants', router);
};
