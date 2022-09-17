const {Sequelize} = require("sequelize");
const dbConfig = require("../dbConfig");

const DB = new Sequelize(
    dbConfig.database,
    dbConfig.username,
    dbConfig.password,
    {...dbConfig.options}
);

module.exports = {DB};
