/*
 * Copyright (c) 2021.
 * All Rights Reserved
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution, and decompilation.
 * @SergioArielJuárez (https://github.com/sergioarieljuarez)
 * @JoseLuisGlavic
 *
 */
const {Sequelize} = require("sequelize");
const dbConfig = require("../dbConfig");

const UsuarioModel = require("./usuarios");
const PostulanteModel = require("./postulantes");
const AnuncioModel = require("./anuncios");

const sequelize = new Sequelize(
    dbConfig.DB,
    dbConfig.USER,
    dbConfig.PASSWORD, {
        host: dbConfig.HOST,
        dialect: dbConfig.dialect,
        operatorsAliases: false,
        pool: {
            max: dbConfig.pool.max,
            min: dbConfig.pool.min,
            acquire: dbConfig.pool.acquire,
            idle: dbConfig.pool.idle
        }
    });

const db = {};

db.sequelize = sequelize;
db.Sequelize = Sequelize;

db.usuarios = UsuarioModel(sequelize, Sequelize);
db.postulantes = PostulanteModel(sequelize, Sequelize);
db.anuncios = AnuncioModel(sequelize, Sequelize);

module.exports = db;
