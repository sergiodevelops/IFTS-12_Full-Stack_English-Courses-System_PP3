module.exports = function(sequelize, DataTypes) {
  // const Sequelize = require('sequelize');
  return sequelize.define('Usuario', {
    IdUsuario: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    username: {
      type: DataTypes.CHAR(20),
      allowNull: false,
      comment: "Alias con el que ingresa al sistema",
      unique: "username"
    },
    password: {
      type: DataTypes.STRING(35),
      allowNull: false,
      comment: "Clave necesaria para ingresar al sistema"
    },
    fecha_alta: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.literal('CURRENT_TIMESTAMP'),
      comment: "Fecha en que se da el alta al usuario"
    },
    vencimiento: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    estado: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    es_admin: {
      type: DataTypes.TINYINT,
      allowNull: false
    },
    IdPersona: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Persona',
        key: 'IdPersona'
      },
      unique: "Usuario_ibfk_1"
    }
  }, {
    sequelize,
    modelName: 'Usuario',
    tableName: 'Usuario',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "IdUsuario" },
        ]
      },
      {
        name: "PersonaUsuario",
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
      {
        name: "username",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "username" },
        ]
      },
    ]
  });
};
