var DataTypes = require("sequelize").DataTypes;
var _Aula = require("./Aula");
var _Idioma = require("./Idioma");

function initModels(sequelize) {
  var Aula = _Aula(sequelize, DataTypes);
  var Idioma = _Idioma(sequelize, DataTypes);


  return {
    Aula,
    Idioma,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
