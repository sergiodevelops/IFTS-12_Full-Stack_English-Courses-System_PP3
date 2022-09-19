var DataTypes = require("sequelize").DataTypes;
var _Anuncio = require("./Anuncio");

function initModels(sequelize) {
  var Anuncio = _Anuncio(sequelize, DataTypes);


  return {
    Anuncio,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
