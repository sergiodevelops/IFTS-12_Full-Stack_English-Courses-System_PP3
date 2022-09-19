
const {Sequelize} = require("sequelize");
const dbConfig = require("../dbConfig");

const UsuarioModel = require("./usuarios");
const PostulanteModel = require("./postulantes");
const AnuncioModel = require("./Anuncio");
// const CursoModel = require("./Curso");

const sequelize = new Sequelize(
    dbConfig.database,
    dbConfig.username,
    dbConfig.password,
    {...dbConfig.options}
);

let db = {};

db.sequelize = sequelize;
db.Sequelize = Sequelize;

db.usuarios = UsuarioModel(sequelize, Sequelize);
db.postulantes = PostulanteModel(sequelize, Sequelize);
// db.anuncios = AnuncioModel(sequelize, Sequelize);
db.Anuncio = AnuncioModel(sequelize, Sequelize);
// db.Curso = CursoModel(sequelize, Sequelize);

module.exports = db;
