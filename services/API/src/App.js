require('dotenv').config();
const {API_PORT, WEB_PORT, DB_PORT} = process.env;
const express = require("express");
const logger = require("morgan");
const bodyParser = require("body-parser"); //analiza la solicitud y crea req.body object
const cors = require("cors"); // middleware Express que habilita CORS con varias opciones
const app = express(); // para usar express
const DB = require("./models/allModels");
const router = require("./routes/allRoutes");

//logger
app.use(logger('dev'));

//------------------------------------------
//MODO desarrollo
//----------------------

DB
    .sequelize
    .query('SET FOREIGN_KEY_CHECKS=0', {raw: true})
    .then(()=> {
        DB
            .sequelize
            .sync({force: true});
    });


//------------------------------------------
// MODO produccion
//----------------------

// DB
//     .sequelize
//     .sync() //MODO produccion
//     .then(() => { //modo dev
//         console.log("Drop and re-sync db.");
//     })
//     .catch((error) => {
//         console.log('el error es:', error)
//     });

//------------------------------------------

const webPort = WEB_PORT || 3005;
let corsOptions = {
    origin: `http://localhost:${webPort}`
};
app.use(cors(corsOptions));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

router(app);

const apiPort = API_PORT || 4005;
const dbPort = DB_PORT || 3306;

app.listen(apiPort, () => {
    console.log("API PORT --> ", (apiPort ? ".env API_PORT --> " : "API_PORT hardcodeado --> "), apiPort);
    console.log("DATABASE  --> ", (dbPort ? ".env DB_PORT --> " : "DB_PORT hardcodeado --> "), dbPort);
});
