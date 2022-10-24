module.exports = function(models) {
    // setup relations
    // models.Usuario.belongsTo(models.Persona, { /*as: "IdPersona_Persona",*/ foreignKey: "IdPersona"});
    // models.Persona.hasOne(models.Usuario, { /*as: "Usuario",*/ foreignKey: "IdPersona"});
    // models.Alumno.belongsTo(models.Persona, { /*as: "IdPersona_Persona",*/ foreignKey: "IdPersona"});
    // models.Persona.hasOne(models.Alumno, { /*as: "Alumno",*/ foreignKey: "IdPersona"});
    // models.Docente.belongsTo(models.Persona, { /*as: "IdPersona_Persona",*/ foreignKey: "IdPersona"});
    // models.Persona.hasOne(models.Docente, { /*as: "Docente",*/ foreignKey: "IdPersona"});
    models.usuarios.hasMany(models.Curso, {foreignKey: "CodDocente"});
    models.Curso.belongsTo(models.usuarios, {as: "Docente", foreignKey: "CodDocente", scope: { tipo_usuario: 2 }});
    models.Aula.hasMany(models.Curso, {foreignKey: "CodAula"})
    models.Curso.belongsTo(models.Aula, {foreignKey: "CodAula"});
    models.Idioma.hasMany(models.Curso, {foreignKey: "CodIdioma"})
    models.Curso.belongsTo(models.Idioma, {foreignKey: "CodIdioma"});
  };