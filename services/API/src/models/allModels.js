
const {Sequelize} = require("sequelize");
const dbConfig = require("../dbConfig");

const UsuarioModel = require("./Usuario");
const PersonaModel = require("./Persona");
// const PostulanteModel = require("./postulantes");
// const AnuncioModel = require("./anuncios");
const CursoModel = require("./Curso");

const sequelize = new Sequelize(
    dbConfig.DB,
    dbConfig.USER,
    dbConfig.PASSWORD, {
        host: dbConfig.HOST,
        dialect: dbConfig.dialect,
        operatorsAliases: false,
        pool: {
            max: dbConfig.pool.max,
            min: dbConfig.pool.min,
            acquire: dbConfig.pool.acquire,
            idle: dbConfig.pool.idle
        }
    });

const db = {};

db.sequelize = sequelize;
db.Sequelize = Sequelize;

db.Usuario = UsuarioModel(sequelize, Sequelize);
db.Persona = PersonaModel(sequelize, Sequelize);
// db.postulantes = PostulanteModel(sequelize, Sequelize);
// db.anuncios = AnuncioModel(sequelize, Sequelize);
db.Curso = CursoModel(sequelize, Sequelize);

module.exports = db;
