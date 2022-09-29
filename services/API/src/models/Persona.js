// const db  = require('./index').db;
// const sequelize = require("sequelize");
// const DataTypes = require('mysql');
// const sequelize = require('./index').sequelize;
module.exports = function(sequelize, DataTypes) {
  // const Sequelize = require('sequelize');
  return sequelize.define('Persona', {
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
    modelName: 'Persona',
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
};
