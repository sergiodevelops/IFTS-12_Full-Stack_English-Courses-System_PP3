const Sequelize = require('sequelize');

module.exports = function(sequelize, DataTypes) {
  const Usuario = sequelize.define('Usuario', {
    IdUsuario: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    contrasenia: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    fecha_creacion: {
      type: DataTypes.DATEONLY,
      allowNull: true
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
      type: DataTypes.BOOLEAN,
      allowNull: false
    },
    IdPersona: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Persona',
        key: 'IdPersona'
      },
      unique: "PersonaUsuario"
    }
  }, {
    sequelize,
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
        name: "IdPersona",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "IdPersona" },
        ]
      },
    ]
  });

  Usuario.associate = (models) => {
    Usuario.belongsTo(models.Persona, {
      foreignKey: {
        name: 'IdUsuario',
        allowNull: false
      },
      as: 'Persona'
    });
  };

  return Usuario;
};
