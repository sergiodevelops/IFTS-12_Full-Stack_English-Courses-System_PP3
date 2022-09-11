/*
 * Copyright (c) 2021.
 * All Rights Reserved
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution, and decompilation.
 * @SergioArielJuárez (https://github.com/sergioarieljuarez)
 * @JoseLuisGlavic
 *
 */
const AnuncioModel = require('../models/allModels').anuncios;

const getPagination = (size, page) => {
    const limit = size ? +size : 10;
    const offset = page ? page * limit : 0;

    return {limit, offset};
};

const getPagingData = (data, page, limit) => {
    const {count: totalItems, rows: jobads} = data;
    const currentPage = page ? +page : 0;
    const totalPages = Math.ceil(totalItems / limit);

    return {totalItems, jobads, totalPages, currentPage};
};

// CREA ANUNCIO (alta)
exports.create = (req, res) => {
    // Validate "puesto_vacante"
    if (!req.body.puesto_vacante) {
        res.status(400).send({
            message: "Debe enviar un 'puesto_vacante' para crear el JobAd!"
        });
        return;
    }
    // Validate "descripcion_tareas"
    if (!req.body.descripcion_tareas) {
        res.status(400).send({
            message: "Debe enviar un 'descripcion_tareas' para crear el JobAd!"
        });
        return;
    }
    // Validate "experiencia"
    if (!req.body.experiencia) {
        res.status(400).send({
            message: "Debe enviar un 'experiencia' para crear el JobAd!"
        });
        return;
    }
    // Validate "estudios"
    if (!req.body.estudios) {
        res.status(400).send({
            message: "Debe enviar un 'estudios' para crear el JobAd!"
        });
        return;
    }

    // Create a JobAd
    const newDbJobAd = {
        puesto_vacante: req.body.puesto_vacante,
        descripcion_tareas: req.body.descripcion_tareas,
        experiencia: req.body.experiencia,
        estudios: req.body.estudios,
    };

    AnuncioModel
        .create(newDbJobAd, {})
        .then(data => {
            res.status(201).send(data);
        })
        .catch(err => {
            res.status(409).send({
                name: "Duplicate JobAd Entry",
                message: `${err}`
            });
        });
};

// MODIFICACIÓN DE USUARIO TOTAL (actualización)
exports.replace = (req, res) => {
    const {id} = req.query;

    AnuncioModel
        .update(
            req.body,
            {where: {id: id}})
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "JobAd was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update Tutorial with id=${id}. Maybe JobAd was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating JobAd with id=" + id
            });
        });
};

// BAJA (elimina el usuario)
exports.delete = (req, res) => {
    const {id} = req.query;

    AnuncioModel
        .destroy({
        where: {id: id}
    })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: `JobAd was deleted successfully! ID=${id}`,
                });
            } else {
                res.send({
                    message: `Cannot delete JobAd with ID=${id}. Maybe JobAd was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: `Could not delete JobAd with ID=${id}`,
            });
        });
};

exports.findAllByFilters = (req, res) => {
    let {size, page, tipo_usuario} = req.query;
    const userTypeIsValid = (tipo_usuario > 0 && tipo_usuario < 4);
    const condition = tipo_usuario ? {tipo_usuario: userTypeIsValid ? tipo_usuario : null} : null;
    const {limit, offset} = getPagination(size, page);

    AnuncioModel
        .findAndCountAll(/*{
                where: condition,
                limit,
                offset
            }*/)
        .then(data => {
            const response = getPagingData(data, page, limit);
            res.send(response);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving jobads."
            });
        });

    // other CRUD functions
};
