module.exports = function(sequelize, DataTypess) {
  const DataTypes = require('sequelize');
  const Curso = sequelize.define('Curso', {
    CodCurso: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    comision: { //NOMBRE DEL CURSO
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
      allowNull: true,
      references: {
        model: 'Nivel_Idioma',
        key: 'Cod_Nivel'
      }
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

      // {
      //   name: "Nivel_IdiomaCurso",
      //   using: "BTREE",
      //   fields: [
      //     { name: "CodNivel" },
      //   ]
      // },
    ]
  });

  return Curso;
};
