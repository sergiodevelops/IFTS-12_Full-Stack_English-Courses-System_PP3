var DataTypes = require("sequelize").DataTypes;
var _Matricula = require("./Matricula");

function initModels(sequelize) {
  var Matricula = _Matricula(sequelize, DataTypes);

  Matricula.belongsTo(Curso, { as: "CodCurso_Curso", foreignKey: "CodCurso"});
  Curso.hasMany(Matricula, { as: "Matriculas", foreignKey: "CodCurso"});
  Matricula.belongsTo(usuarios, { as: "Legajo_usuario", foreignKey: "Legajo"});
  usuarios.hasMany(Matricula, { as: "Matriculas", foreignKey: "Legajo"});

  return {
    Matricula,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
