var DataTypes = require("sequelize").DataTypes;
var _Persona = require("./Persona");
var _Usuario = require("./Usuario");
var _Alumno = require("./Alumno");
var _Docente = require("./Docente");

function initModels(sequelize) {
  var Persona = _Persona(sequelize, DataTypes);
  var Usuario = _Usuario(sequelize, DataTypes);
  var Alumno = _Alumno(sequelize, DataTypes);
  var Docente = _Docente(sequelize, DataTypes);

  Usuario.belongsTo(Persona, { as: "IdPersona_Persona", foreignKey: "IdPersona"});
  Persona.hasOne(Usuario, { as: "Usuario", foreignKey: "IdPersona"});
  Alumno.belongsTo(Persona, { as: "IdPersona_Persona", foreignKey: "IdPersona"});
  Persona.hasOne(Alumno, { as: "Alumno", foreignKey: "IdPersona"});
  Docente.belongsTo(Persona, { as: "IdPersona_Persona", foreignKey: "IdPersona"});
  Persona.hasOne(Docente, { as: "Docente", foreignKey: "IdPersona"});

  return {
    Persona,
    Usuario,
    Alumno,
    Docente,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
