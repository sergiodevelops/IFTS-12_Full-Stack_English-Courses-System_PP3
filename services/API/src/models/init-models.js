var DataTypes = require("sequelize").DataTypes;
var _Curso = require("./Curso");

function initModels(sequelize) {
  var Curso = _Curso(sequelize, DataTypes);

  Curso.belongsTo(Aula, { as: "CodAula_Aula", foreignKey: "CodAula"});
  Aula.hasMany(Curso, { as: "Cursos", foreignKey: "CodAula"});
  Curso.belongsTo(Docente, { as: "CodDocente_Docente", foreignKey: "CodDocente"});
  Docente.hasMany(Curso, { as: "Cursos", foreignKey: "CodDocente"});
  Curso.belongsTo(Idioma, { as: "CodIdioma_Idioma", foreignKey: "CodIdioma"});
  Idioma.hasMany(Curso, { as: "Cursos", foreignKey: "CodIdioma"});
  Curso.belongsTo(Nivel_Idioma, { as: "CodNivel_Nivel_Idioma", foreignKey: "CodNivel"});
  Nivel_Idioma.hasMany(Curso, { as: "Cursos", foreignKey: "CodNivel"});

  return {
    Curso,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
