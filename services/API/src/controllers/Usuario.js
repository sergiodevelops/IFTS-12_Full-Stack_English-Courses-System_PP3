const {Usuario, Persona} = require('../models');

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
    // Validate "contrasenia"
    if (!req.body.contrasenia) {
        res.status(400).send({
            message: "Debe enviar un 'contrasenia' para crear el User!"
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
        es_admin: req.body.es_admin,
        nombre_completo: req.body.nombre_completo,
        username: req.body.username,
        contrasenia: req.body.contrasenia,
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

    // Validate "contrasenia"
    if (!req.body.contrasenia) {
        res.status(400).send({
            name: "PasswordEmptyEntry",
            message: "Debe ingresar una 'contrasenia' para poder iniciar sesión!"
        });
        return;
    }

    // Find User in the database by "username" and "contrasenia"
    Usuario
        .findOne({where: {username: req.body.username}})
        .then((user) => {
                if (user && user.contrasenia === req.body.contrasenia) {
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

// CONSULTA (obtiene los usuarios segun filtros)
exports.findAllByFilters = (req, res) => {

    let {size, page, es_admin} = req.query;
    const userTypeIsValid = (es_admin > 0 && es_admin < 4);
    const condition = es_admin ? {es_admin: userTypeIsValid ? es_admin : null} : null;
    const {limit, offset} = getPagination(size, page);
    // const {IdPersona} = Persona;

    Usuario
        .findAndCountAll({
            where: condition,
            include: [{
                model : Persona,
                required: true,
                attributes :[
                    "documento",
                    "nombre",
                    "apellido",
                    "fecha_nac",
                    "email",
                ],
            }],
            offset, limit,
        })
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
