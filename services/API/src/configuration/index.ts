import { Sequelize } from "sequelize";

type CONNECTION_OPTIONS = "mysql" | "postgres" | "sqlite" | "mariadb" | "mssql" | undefined;

const DB_DIALECT: CONNECTION_OPTIONS = process.env.DB_DIALECT === "mysql" ? "mysql" : undefined;
const DB_HOST: string = process.env.DB_HOST || "";
const DB_PORT: string = process.env.DB_PORT || "";
const DB_USERNAME: string = process.env.DB_USERNAME || "";
const DB_PASSWORD: string = process.env.DB_PASSWORD || "";

const sequelize = new Sequelize(DB_PORT, DB_USERNAME, DB_PASSWORD, {
    host: DB_HOST,
    dialect: DB_DIALECT
});

try {
    sequelize.authenticate();
    console.info(`Connection has been established successfully to database ${DB_PORT}`);

} catch (error) {
    console.error(`errors: ' ${error}`);
    throw Error(error);
}

export default sequelize;
