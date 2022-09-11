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
  return sequelize.define('anuncios', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      primaryKey: true
    },
    puesto_vacante: {
      type: DataTypes.STRING(100),
      allowNull: false,
      comment: "Descripción resumida del puesto a cubrir"
    },
    descripcion_tareas: {
      type: DataTypes.STRING(200),
      allowNull: false,
      comment: "Breve descripción de las tareas a complir"
    },
    experiencia: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    estudios: {
      type: DataTypes.STRING(200),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'anuncios',
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
    ]
  });
};
