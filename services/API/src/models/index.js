const {Sequelize} = require("sequelize");
const dbConfig = require("../dbConfig");

const usuariosModel = require("./usuarios");
const UsuarioModel = require("./Usuario");
const PersonaModel = require("./Persona");
const AnuncioModel = require("./Anuncio");
const CursoModel = require("./Curso");
const AulaModel = require("./Aula");

let db = {};
db.Sequelize = Sequelize;

const sequelize = new Sequelize(
    dbConfig.database,
    dbConfig.username,
    dbConfig.password,
    {...dbConfig.options}
);

db.sequelize = sequelize;
db.usuarios = usuariosModel(sequelize, Sequelize);
db.Usuario = UsuarioModel(sequelize, Sequelize);
db.Persona = PersonaModel(sequelize, Sequelize);
db.Anuncio = AnuncioModel(sequelize, Sequelize);
db.Curso = CursoModel(sequelize, Sequelize);
db.Aula = AulaModel(sequelize, Sequelize);

require("./relations")(sequelize.models);

module.exports = db;
