const {Sequelize} = require("sequelize");
const dbConfig = require("../dbConfig");
const UsuarioModel = require("./usuarios");
const AnuncioModel = require("./Anuncio");
//const CursoModel = require("./Curso");

let db = {};
db.Sequelize = Sequelize;
const sequelize = new Sequelize(
    dbConfig.database,
    dbConfig.username,
    dbConfig.password,
    {...dbConfig.options}
);
db.sequelize = sequelize;
db.usuarios = UsuarioModel(sequelize, Sequelize);
db.Anuncio = AnuncioModel(sequelize, Sequelize);
//db.Curso = CursoModel(sequelize, Sequelize);

module.exports = db;
