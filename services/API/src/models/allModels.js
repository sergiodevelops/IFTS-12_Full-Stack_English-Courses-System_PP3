
const {Sequelize} = require("sequelize");
const dbConfig = require("../dbConfig");

const UsuarioModel = require("./usuarios");
const PostulanteModel = require("./postulantes");
const AnuncioModel = require("./anuncios");
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

db.usuarios = UsuarioModel(sequelize, Sequelize);
db.postulantes = PostulanteModel(sequelize, Sequelize);
db.anuncios = AnuncioModel(sequelize, Sequelize);
db.Curso = CursoModel(sequelize, Sequelize);

module.exports = db;
