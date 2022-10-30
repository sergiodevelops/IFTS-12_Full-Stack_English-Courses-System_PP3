module.exports = function(sequelize, DataTypess) {
  const DataTypes = require('sequelize');
  const Persona = sequelize.define('Persona', {
    IdPersona: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    documento: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    tipo_documento: {
      type: DataTypes.STRING(30),
      allowNull: true
    },
    nombre: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    apellido: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    sexo: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    fecha_nac: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    email: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    calle: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    numero: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    departamento: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    localidad: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    provincia: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    pais: {
      type: DataTypes.STRING(100),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'Persona',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "IdPersona" },
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

  // Persona.associate = (models) => {
  //   Persona.hasOne(models.Usuario, {
  //     foreignKey: {
  //       name: 'IdUsuario',
  //       allowNull: false
  //     },
  //     as: 'Persona'
  //   });
  // };

  return Persona;
};
