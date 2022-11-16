const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('usuarios', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      primaryKey: true,
      comment: "Identificador único del usuario"
    },
    tipo_usuario: {
      type: DataTypes.TINYINT,
      allowNull: false,
      comment: "Si el usuario es un postulante =1 , o es un solicitante = 2 , o es Administrativo = 3"
    },
    nombre_completo: {
      type: DataTypes.STRING(50),
      allowNull: false,
      comment: "Nombres y apellidos del usuario"
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
      defaultValue: Sequelize.Sequelize.literal('CURRENT_TIMESTAMP'),
      comment: "Fecha en que se da el alta al usuario"
    }
  }, {
    sequelize,
    tableName: 'usuarios',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
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
