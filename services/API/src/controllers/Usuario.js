// const { DataTypes } = require('sequelize/types');
const Sequelize = require('sequelize');
const {Usuario, Persona, Docente, sequelize, Alumno} = require('../models');

const getPagination = (size, page) => {
    const limit = size ? +size : 10;
    const offset = page ? page * limit : 0;
    return {limit, offset};
};

const getPagingData = (data, page, limit) => {
    const {count: totalItems, rows: users} = data;
    const currentPage = page ? +page : 0;
    const totalPages = Math.ceil(totalItems / limit);
    return {totalItems, users, totalPages, currentPage};
};

// ALTA (crea nuevo usuario)
exports.create = (req, res) => {
    // Validate "es_admin"
    if (!req.body.es_admin) {
        res.status(400).send({
            message: "Debe enviar un 'es_admin' para crear el User!"
        });
        return;
    }
    // Validate "username"
    if (!req.body.username) {
        res.status(400).send({
            message: "Debe enviar un 'username' para crear el User!"
        });
        return;
    }
    // Validate "password"
    if (!req.body.password) {
        res.status(400).send({
            message: "Debe enviar un 'password' para crear el User!"
        });
        return;
    }
    // Generate "startDate"
    const formatoFecha = (fecha, formato) => {
        return formato
            .replace('YYYY', fecha.getFullYear())
            .replace('MM', fecha.getMonth() + 1)
            .replace('DD', fecha.getDate());
    }

    // Create a User
    const newDbUser = {
        documento: req.body.documento,
        tipo_documento: req.body.tipo_documento, // Agregar default "DNI"
        nombre: req.body.nombre,
        apellido: req.body.apellido,
        fecha_nac: req.body.fecha_nac,
        email: req.body.email,
        // nombre_completo: req.body.nombre_completo,
        tipo_usuario: req.body.tipo_usuario, // Que según el valor grabe en "Docente" o "Alumno"
        username: req.body.username,
        password: req.body.password,
        es_admin: req.body.es_admin,
    };



    // Save User in the database if "username" not exist
    Usuario
        .create(newDbUser, {username: req.body.username})
        .then(data => {
            res.status(201).send(data);
        })
        .catch(err => {
            res.status(409).send({
                name: "Duplicate Username Entry",
                message: `El usuario "${req.body.username}" ya existe, intente con uno diferente.`
            });
        });
};

// MODIFICACIÓN DE USUARIO TOTAL (actualización)
exports.replace = (req, res) => {
    const {id} = req.query;

    Usuario
        .update(
            req.body,
            {where: {id: id}})
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "User was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update Tutorial with id=${id}. Maybe User was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating User with id=" + id
            });
        });
};

// BAJA (elimina el usuario)
exports.delete = (req, res) => {
    const {id} = req.query;

    Usuario.destroy({
        where: {id: id}
    })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "User was deleted successfully!" + id
                });
            } else {
                res.send({
                    message: `Cannot delete User with id=${id}. Maybe User was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete User with id=" + id
            });
        });
};


// LOGIN (recupera si existe el usuario que coincida por username y pass)
exports.login = (req, res) => {
    // Validate "username"
    if (!req.body.username) {
        res.status(400).send({
            name: "UsernameEmptyEntry",
            message: "Debe enviar un 'username' para poder iniciar sesión!"
        });
        return;
    }

    // Validate "password"
    if (!req.body.password) {
        res.status(400).send({
            name: "PasswordEmptyEntry",
            message: "Debe ingresar una 'password' para poder iniciar sesión!"
        });
        return;
    }

    // Find User in the database by "username" and "password"
    Usuario
        .findOne({where: {username: req.body.username}})
        .then((user) => {
                if (user && user.password === req.body.password) {
                    res.status(200).send(user);
                }
                res.status(404).send({
                    name: "Credentials Wrong",
                    message: `Las credenciales ingresadas para autenticarse no son validas, intente nuevamente`
                });
            }
        )
        .catch((err) => {
            res.status(500).send({
                name: `${err.name}`,
                message: `${err.message}`
            });
        });
};


// CONSULTA (valida si existe un admin)
exports.findOneByFilters = (req, res) => {
    // const user = await Usuario.findOne({ where: { es_admin: 1 } });
    // if (user === null) {
    //     console.log('Not found!');
    // } else {
    //     console.log(user instanceof Project); // true
    //     console.log(user.title); // 'My Title'
    // }
    let {es_admin} = req.query;
    const userAdminIsValid = (es_admin >= 0 && es_admin < 2);
    const condition = es_admin ? {es_admin: userAdminIsValid ? es_admin : null} : null;

    Usuario.findOne({ 
        where: condition,
        attributes: {
            include: [
                [
                    sequelize.literal(`(
                        SELECT * FROM (
                            SELECT CASE
                                WHEN (SELECT docente.CodDocente 
                                    FROM Docente AS docente, Usuario as usuario
                                    WHERE docente.IdPersona = usuario.IdPersona 
                                ) IS NOT NULL THEN 2
                                WHEN (SELECT alumno.Legajo
                                    FROM Alumno AS alumno, Usuario as usuario
                                    WHERE alumno.IdPersona = usuario.IdPersona 
                                ) IS NOT NULL THEN 3
                                ELSE 1
                            END AS tipo_usuario
                        ) tipo
                    )`),
                    'tipo_usuario'
                ],
                [
                    sequelize.literal(`(
                        SELECT 
                            CONCAT(persona.nombre, ' ', persona.apellido) AS nombre_completo
                        FROM Usuario as usuario, Persona as persona
                    )`),
                    'nombre_completo'
                ]
            ],
            exclude: [
                'vencimiento',
                'estado',
                'IdPersona'
            ],
        },
        include: [{
            model: Persona,
            required: true,
            attributes: [
                'IdPersona',
                'documento',
                'nombre',
                'apellido',
                'fecha_nac',
                'email',
            ],
        }],
    })
    .then((user) => {
        console.log("EXISTE ADMIN");
        // const response = getPagingData(data, page, limit);
        res.status(200).send(user);
    })
    .catch(err => {
        res.status(500).send({
            message:
                err.message || "Some error occurred while retrieving users."
        });
    });
}

// CONSULTA (obtiene los usuarios segun filtros)
exports.findAllByFilters = (req, res) => {
    const { Op } = require("sequelize");
    let {size, page, es_admin, tipo_usuario} = req.query;
    console.log("#### TIPO: ", typeof es_admin);
    const userAdminIsValid = (es_admin >= 0 && es_admin < 2);
    const userTypeIsValid = (tipo_usuario > 1 && tipo_usuario < 4);
    const condition = es_admin ? {es_admin: userAdminIsValid ? es_admin : null} : null;
    // const condition1 = es_admin ? userAdminIsValid ? es_admin : '%' : '%';
    const condition2 = tipo_usuario ? userTypeIsValid ? tipo_usuario : '%' : '%' ;
    // const condition = es_admin ? {es_admin: userAdminIsValid ? es_admin : null} : tipo_usuario ? {tipo_usuario: userTypeIsValid ? tipo_usuario : null} : null;
    const {limit, offset} = getPagination(size, page);
    // const {IdPersona} = Persona;
    // console.log("#### CONDICION: ", condition1);
    
    Usuario
        .findAndCountAll({
            where: condition,
            // where: { es_admin: {[Op.like]: condition1},
            //     // tipo_usuario: {[Op.not]: null}
            // }, 
            attributes: {
                include: [
                    [
                        sequelize.literal(`(
                            SELECT * FROM (
                                SELECT CASE
                                    WHEN (SELECT docente.CodDocente 
                                        FROM Docente AS docente, Usuario as usuario
                                        WHERE docente.IdPersona = usuario.IdPersona 
                                    ) IS NOT NULL THEN 2
                                    WHEN (SELECT alumno.Legajo
                                        FROM Alumno AS alumno, Usuario as usuario
                                        WHERE alumno.IdPersona = usuario.IdPersona 
                                    ) IS NOT NULL THEN 3
                                    ELSE 1
                                END AS tipo_usuario
                            ) tipo
                            /*WHERE tipo.tipo_usuario LIKE '${condition2}'*/
                        )`),
                        'tipo_usuario'
                    ],
                    [
                        sequelize.literal(`(
                            SELECT 
                                CONCAT(persona.nombre, ' ', persona.apellido) AS nombre_completo
                            FROM Usuario as usuario, Persona as persona
                        )`),
                        'nombre_completo'
                    ]
                ],
                exclude: [
                    'IdUsuario',
                    'vencimiento',
                    'estado',
                    'IdPersona'
                ],
                // group: ['Usuario.IdUsuario'],
                // having: { tipo_usuario: {[Op.not]: null} }
            },
            include: [{
                model: Persona,
                // as: "IdPersona_Persona",
                required: true,
                attributes: [
                    'IdPersona',
                    'documento',
                    'nombre',
                    'apellido',
                    'fecha_nac',
                    'email',
                ],
                // include: [{
                //     model: Docente,
                //     attributes: [
                //         [Sequelize.literal('2'), 'tipo_usuario'] // VirtualColumn
                //     ]
                // }, {
                //     model: Alumno,
                //     attributes: [
                //         [Sequelize.literal('3'), 'tipo_usuario'] // VirtualColumn
                //     ]
                // }]
            }],
            // group: ['Usuario.IdUsuario'],
            // having: { 'tipo_usuario': {[Op.not]: null} },
            // having: { 'distance': { [Sequelize.Op.lte]: ':maxDistance' } }
            // having: sequelize.literal(`tipo_usuario IS NOT NULL`),
            // having: where( sequelize.fn('min', sequelize.col('guarantees.start_date')), 'start_date', { [sequelize.Op.gte]: new Date() } ),
            // having: sequelize.where( [sequelize.literal(`(
            //     SELECT * FROM (
            //         SELECT CASE
            //             WHEN (SELECT docente.CodDocente 
            //                 FROM Docente AS docente, Usuario as usuario
            //                 WHERE docente.IdPersona = usuario.IdPersona 
            //             ) IS NOT NULL THEN '2'
            //             WHEN (SELECT alumno.Legajo
            //                 FROM Alumno AS alumno, Usuario as usuario
            //                 WHERE alumno.IdPersona = usuario.IdPersona 
            //             ) IS NOT NULL THEN '3'
            //             ELSE '1'
            //         END AS tipo_usuario
            //     ) tipo
            //     WHERE tipo.tipo_usuario LIKE '${condition2}'
            // )`), 'tipo_usuario'], 
            //     {[Op.not]: null}),

            //     having: sequelize.and(
            //         sequelize.where(sequelize.fn('count', sequelize.col('user.id')), {
            //                           [Op.gte]: users.length,
            //                         }),
            //         sequelize.where(sequelize.fn('count', sequelize.col('role.id')), {
            //                           [Op.gte]: roles.length,
            //                         }),
            //         ),
            limit, offset
        })
        // .findAndCountAll({
        //     where: condition,
        //     include: [{
        //         model : Persona,
        //         required: true,
        //         attributes :[
        //             "IdPersona",
        //             "documento",
        //             "nombre",
        //             "apellido",
        //             "fecha_nac",
        //             "email",
        //         ],
        //         include: [{
        //             where: {
        //                 // here you can use custom subquery to select only buckets that has AT LEAST one "red" color
        //                 $and: [['EXISTS( SELECT * FROM "Docente" WHERE IdPersona = ?)', Persona.IdPersona]]
        //               },
        //             include: [
        //             // and then join all colors for each bucket that meets previous requirement ("at least one...")
        //             //{ model: Color, as: 'colors' }
        //             {'tipo_usuario': "2"}
        //             ]
        //         }]
        //     }],
        //     offset, limit,
        // })
        .then(data => {
            console.log("data");
            const response = getPagingData(data, page, limit);
            res.send(response);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving users."
            });
        });
};

/*
// MODIFICACIÓN DE USUARIO COMPLETO (reemplazo)
exports.update = (req, res) => {
    const id = req.params.id;

    Usuario
        .update(req.body, {where: {id: id}})
        .then(data => {
            if (data == 1) {
                res.send({
                    message: "User was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update Tutorial with id=${id}. Maybe User was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating User with id=" + id + err.message
            });
        });
};*/
