/*
 * Copyright (c) 2021.
 * All Rights Reserved
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution, and decompilation.
 * @SergioArielJuárez (https://github.com/sergioarieljuarez)
 * @JoseLuisGlavic
 *
 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('postulantes', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      primaryKey: true
    },
    dni: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      comment: "Nro de documento",
      unique: "dni"
    },
    apellido: {
      type: DataTypes.STRING(100),
      allowNull: false,
      comment: "Apellidos"
    },
    nombres: {
      type: DataTypes.STRING(100),
      allowNull: false,
      comment: "Nombres"
    },
    tel: {
      type: DataTypes.STRING(100),
      allowNull: false,
      comment: "teléfonos"
    },
    email: {
      type: DataTypes.STRING(100),
      allowNull: false,
      comment: "direcciones de correos electrónicos"
    }
  }, {
    sequelize,
    tableName: 'postulantes',
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
        name: "idx_dni",
        using: "BTREE",
        fields: [
          { name: "dni" },
        ]
      },
      {
        name: "idx_apellido",
        using: "BTREE",
        fields: [
          { name: "apellido" },
          { name: "nombres" },
        ]
      },
      {
        name: "dni",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "dni" },
        ]
      },

    ]
  });
};
