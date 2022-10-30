module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Matricula', {
    IdMatricula: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    fecha: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    estado: {
      type: DataTypes.STRING(20),
      allowNull: true,
      defaultValue: "ACTIVO"
    },
    CodCurso: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Curso',
        key: 'CodCurso'
      }
    },
    Legajo: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: true,
      references: {
        model: 'usuarios',
        key: 'id'
      }
    }
  }, {
    sequelize,
    tableName: 'Matricula',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "IdMatricula" },
        ]
      },
      {
        name: "AlumnoMatricula",
        using: "BTREE",
        fields: [
          { name: "Legajo" },
        ]
      },
      {
        name: "CursoMatricula",
        using: "BTREE",
        fields: [
          { name: "CodCurso" },
        ]
      },
    ]
  });
};
