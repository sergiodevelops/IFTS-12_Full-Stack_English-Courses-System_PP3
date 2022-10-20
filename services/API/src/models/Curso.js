module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Curso', {
    CodCurso: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    comision: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    CodAula: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Aula',
        key: 'CodAula'
      }
    },
    CodIdioma: {
      defaultValue: 1,
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Idioma',
        key: 'CodIdioma'
      }
    },
    CodDocente: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Docente',
        key: 'CodDocente'
      }
    },
    CodNivel: {
      type: DataTypes.INTEGER,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'Curso',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "CodCurso" },
        ]
      },
      {
        name: "AulaCurso",
        using: "BTREE",
        fields: [
          { name: "CodAula" },
        ]
      },
      {
        name: "DocenteCurso",
        using: "BTREE",
        fields: [
          { name: "CodDocente" },
        ]
      },
      {
        name: "IdiomaCurso",
        using: "BTREE",
        fields: [
          { name: "CodIdioma" },
        ]
      },
    ]
  });
};
