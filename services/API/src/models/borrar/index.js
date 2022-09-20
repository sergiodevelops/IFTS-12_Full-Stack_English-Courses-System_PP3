const {PersonaModel} = require ('./Persona');
const {UsuarioModel} = require ('./Usuario');

// UsuarioModel.belongsTo(PersonaModel, {foreignKey: 'IdPersona'});
// PersonaModel.hasOne(UsuarioModel, {foreignKey: 'IdPersona'});

module.exports = {
    PersonaModel,
    UsuarioModel,
};
