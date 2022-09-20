module.exports = (app) => {
    const PostulanteController = require("../controllers/postulantes");
    const router = require("express").Router();

    router.post("/create", PostulanteController.create);
    router.get("/", PostulanteController.findAllByFilters);
    router.put("/", PostulanteController.replace);
    router.delete("/", PostulanteController.delete);

    app.use('/api/applicants', router);
};
