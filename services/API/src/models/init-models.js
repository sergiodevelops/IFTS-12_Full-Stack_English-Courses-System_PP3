var DataTypes = require("sequelize").DataTypes;
var _Aula = require("./Aula");
var _Curso = require("./Curso");
var _Idioma = require("./Idioma");
var _Matricula = require("./Matricula");
var _usuarios = require("./usuarios");

function initModels(sequelize) {
  var Aula = _Aula(sequelize, DataTypes);
  var Curso = _Curso(sequelize, DataTypes);
  var Idioma = _Idioma(sequelize, DataTypes);
  var Matricula = _Matricula(sequelize, DataTypes);
  var usuarios = _usuarios(sequelize, DataTypes);

  Curso.belongsTo(Aula, { as: "CodAula_Aula", foreignKey: "CodAula"});
  Aula.hasMany(Curso, { as: "Cursos", foreignKey: "CodAula"});
  Matricula.belongsTo(Curso, { as: "CodCurso_Curso", foreignKey: "CodCurso"});
  Curso.hasMany(Matricula, { as: "Matriculas", foreignKey: "CodCurso"});
  Curso.belongsTo(Idioma, { as: "CodIdioma_Idioma", foreignKey: "CodIdioma"});
  Idioma.hasMany(Curso, { as: "Cursos", foreignKey: "CodIdioma"});
  Curso.belongsTo(usuarios, { as: "CodDocente_usuario", foreignKey: "CodDocente"});
  usuarios.hasMany(Curso, { as: "Cursos", foreignKey: "CodDocente"});
  Matricula.belongsTo(usuarios, { as: "Legajo_usuario", foreignKey: "Legajo"});
  usuarios.hasMany(Matricula, { as: "Matriculas", foreignKey: "Legajo"});

  return {
    Aula,
    Curso,
    Idioma,
    Matricula,
    usuarios,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
