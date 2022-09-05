import express from 'express';
const app = express();
const port = process.env.PORT || 3000;
import db from './src/models';

db.sequelize
    .sync()
    .then(()=>{
        db.sequelize.sync({force: true}); //dev mode
        app.listen(port, ()=> {
            console.log(`REST_API app listening on port ::${port}`)
        })
    });