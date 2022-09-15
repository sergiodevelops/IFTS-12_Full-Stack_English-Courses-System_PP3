var DataTypes = require("sequelize").DataTypes;
var _Usuario = require("./Usuario");

function initModels(sequelize) {
  var Usuario = _Usuario(sequelize, DataTypes);

  Usuario.belongsTo(Persona, { as: "IdPersona_Persona", foreignKey: "IdPersona"});
  Persona.hasOne(Usuario, { as: "Usuario", foreignKey: "IdPersona"});

  return {
    Usuario,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
