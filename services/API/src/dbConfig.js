// CONFIGURAMOS LA CONEXIÓN DE SEQUELIZE CON LA DB
require('dotenv').config();
const {
    DB_HOST,
    DB_PORT,
    DB_USERNAME,
    DB_PASSWORD,
    DB_NAME,
    DB_DIALECT,
} = process.env;

const dbConfig = {
    PORT: DB_PORT || "3306",
    DB: DB_NAME || "db_name",
    USER: DB_USERNAME || "admin",
    PASSWORD: DB_PASSWORD || "1234",
    HOST: DB_HOST || "localhost",
    dialect: DB_DIALECT || "mysql",
    pool: {
        max: 5, //número máximo de conexiones simultaneas
        min: 0, //número mínimo de conexiones simultaneas
        acquire: 30000, //tiempo máximo, en milisegundos, que una conexión puede estar inactiva antes de ser liberada
        idle: 10000, //tiempo máximo, en milisegundos, que el grupo intentará conectarse antes de lanzar el error
    },
};

module.exports = dbConfig;
