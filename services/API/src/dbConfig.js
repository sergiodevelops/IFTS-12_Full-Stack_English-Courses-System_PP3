// CONFIGURAMOS LA CONEXIÓN DE SEQUELIZE CON LA DB
require('dotenv').config();

const dbConfig = {
    database: process.env.DB_NAME || "DB_NAME",
    username: process.env.DB_USERNAME || "DB_USERNAME",
    password: process.env.DB_PASSWORD || "DB_PASSWORD",
    options: {
        host: process.env.DB_HOST || "DB_HOST",
        dialect: process.env.DB_DIALECT || "DB_DIALECT",
        // operatorsAliases: false,
        port: process.env.DB_PORT || "DB_PORT",
        pool: {
            max: 5, //número máximo de conexiones simultaneas
            min: 0, //número mínimo de conexiones simultaneas
            acquire: 30000, //tiempo máximo, en milisegundos, que una conexión puede estar inactiva antes de ser liberada
            idle: 10000, //tiempo máximo, en milisegundos, que el grupo intentará conectarse antes de lanzar el error
        },
    },
};

module.exports = dbConfig;
