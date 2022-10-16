module.exports = (app) => {
    const UsuarioController = require("../controllers/Usuario");
    const router = require("express").Router();

    router.post("/create", UsuarioController.create);
    router.post("/login", UsuarioController.login);
    router.get("/", UsuarioController.findAllByFilters);
    router.put("/", UsuarioController.replace);
    router.delete("/", UsuarioController.delete);

    app.use('/api/user', router);
};
