module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Idioma', {
    CodIdioma: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    nombre: {
      type: DataTypes.STRING(50),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'Idioma',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "CodIdioma" },
        ]
      },
      {
        name: "nombre",
        using: "BTREE",
        fields: [
          { name: "nombre" },
        ]
      },
    ]
  });
};
