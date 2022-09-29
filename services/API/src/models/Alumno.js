const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Alumno', {
    Legajo: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    IdPersona: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Persona',
        key: 'IdPersona'
      },
      unique: "PersonaAlumno"
    }
  }, {
    sequelize,
    tableName: 'Alumno',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "Legajo" },
        ]
      },
      {
        name: "IdPersona",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "IdPersona" },
        ]
      },
    ]
  });
};
