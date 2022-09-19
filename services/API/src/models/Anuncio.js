const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Anuncio', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      primaryKey: true
    },
    titulo: {
      type: DataTypes.STRING(50),
      allowNull: false,
      comment: "Descripción resumida del puesto a cubrir"
    },
    descripcion: {
      type: DataTypes.STRING(300),
      allowNull: false,
      comment: "Breve descripción de las tareas a complir"
    },
    fecha_alta: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: Sequelize.literal('CURRENT_TIMESTAMP'),
      comment: "Fecha en que se da el alta al anuncio"
    }
  }, {
    sequelize,
    tableName: 'Anuncio',
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
