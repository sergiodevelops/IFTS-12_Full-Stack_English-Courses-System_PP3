module.exports = function(models) {
    // setup relations
    models.Usuario.belongsTo(models.Persona, { /*as: "IdPersona_Persona",*/ foreignKey: "IdPersona"});
    models.Persona.hasOne(models.Usuario, { /*as: "Usuario",*/ foreignKey: "IdPersona"});
    models.Alumno.belongsTo(models.Persona, { /*as: "IdPersona_Persona",*/ foreignKey: "IdPersona"});
    models.Persona.hasOne(models.Alumno, { /*as: "Alumno",*/ foreignKey: "IdPersona"});
    models.Docente.belongsTo(models.Persona, { /*as: "IdPersona_Persona",*/ foreignKey: "IdPersona"});
    models.Persona.hasOne(models.Docente, { /*as: "Docente",*/ foreignKey: "IdPersona"});
  };