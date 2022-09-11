/*
 * Copyright (c) 2021.
 * All Rights Reserved
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution, and decompilation.
 * @SergioArielJuárez (https://github.com/sergioarieljuarez)
 * @JoseLuisGlavic
 *
 */
const UsuarioModel = require('../models/allModels').usuarios;

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
    // Validate "tipo_usuario"
    if (!req.body.tipo_usuario) {
        res.status(400).send({
            message: "Debe enviar un 'tipo_usuario' para crear el User!"
        });
        return;
    }
    // Validate "nombre_completo"
    if (!req.body.nombre_completo) {
        res.status(400).send({
            message: "Debe enviar un 'nombre_completo' para crear el User!"
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
        tipo_usuario: req.body.tipo_usuario,
        nombre_completo: req.body.nombre_completo,
        username: req.body.username,
        password: req.body.password,
    };

    // Save User in the database if "username" not exist
    UsuarioModel
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

    UsuarioModel
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

    UsuarioModel.destroy({
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
    UsuarioModel
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

// CONSULTA (obtiene los usuarios segun filtros)
exports.findAllByFilters = (req, res) => {
    let {size, page, tipo_usuario} = req.query;
    const userTypeIsValid = (tipo_usuario > 0 && tipo_usuario < 4);
    const condition = tipo_usuario ? {tipo_usuario: userTypeIsValid ? tipo_usuario : null} : null;
    const {limit, offset} = getPagination(size, page);

    UsuarioModel
        .findAndCountAll({where: condition, limit, offset})
        .then(data => {
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

    UsuarioModel
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
