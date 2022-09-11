/*
 * Copyright (c) 2021.
 * All Rights Reserved
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution, and decompilation.
 * @SergioArielJuárez (https://github.com/sergioarieljuarez)
 * @JoseLuisGlavic
 *
 */
const PostulanteModel = require('../models/allModels').postulantes;

const getPagination = (size, page) => {
    const limit = size ? +size : 10;
    const offset = page ? page * limit : 0;

    return {limit, offset};
};

const getPagingData = (data, page, limit) => {
    const {count: totalItems, rows: applicants} = data;
    const currentPage = page ? +page : 0;
    const totalPages = Math.ceil(totalItems / limit);

    return {totalItems, applicants, totalPages, currentPage};
};

// CREA POSTULANTE (alta)
exports.create = (req, res) => {
    // Validate "dni"
    if (!req.body.dni) {
        res.status(400).send({
            message: "Debe enviar un 'dni' para crear el ApplicantInfo!"
        });
        return;
    }
    // Validate "apellido"
    if (!req.body.apellido) {
        res.status(400).send({
            message: "Debe enviar un 'apellido' para crear el ApplicantInfo!"
        });
        return;
    }
    // Validate "nombres"
    if (!req.body.nombres) {
        res.status(400).send({
            message: "Debe enviar un 'nombres' para crear el ApplicantInfo!"
        });
        return;
    }
    // Validate "tel"
    if (!req.body.tel) {
        res.status(400).send({
            message: "Debe enviar un 'tel' para crear el ApplicantInfo!"
        });
        return;
    }
    // Validate "email"
    if (!req.body.email) {
        res.status(400).send({
            message: "Debe enviar un 'email' para crear el ApplicantInfo!"
        });
        return;
    }

    // Create a ApplicantInfo
    const newDbApplicantInfo = {
        dni: req.body.dni,
        apellido: req.body.apellido,
        nombres: req.body.nombres,
        tel: req.body.tel,
        email: req.body.email,
    };

    // Save ApplicantInfo in the database if "username" not exist
    PostulanteModel
        .create(
            newDbApplicantInfo,
            {
                dni: req.body.dni,
                email: req.body.email,
            }
        )
        .then(data => {
            res.status(201).send(data);
        })
        .catch(err => {
            res.status(409).send({
                name: "Duplicate DNI or EMAIL Entry",
                message: `El info de postulante "${req.body.dni} ${req.body.email}" ya existe, intente con uno diferente.`,
                error: err,
            });
        });
};

// MODIFICACIÓN DE USUARIO TOTAL (actualización)
exports.replace = (req, res) => {
    const {id} = req.query;

    PostulanteModel
        .update(
            req.body,
            {where: {id: id}})
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "Applicant was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update Tutorial with id=${id}. Maybe Applicant was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating Applicant with id=" + id
            });
        });
};

// BAJA (elimina el info de postulante)
exports.delete = (req, res) => {
    const {id} = req.query;

    PostulanteModel
        .destroy({
            where: {id: id}
        })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "Applicant was deleted successfully!" + id
                });
            } else {
                res.send({
                    message: `Cannot delete Applicant with id=${id}. Maybe Applicant was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete Applicant with id=" + id
            });
        });
};

exports.findAllByFilters = (req, res) => {
    let {size, page, tipo_usuario} = req.query;
    const userTypeIsValid = (tipo_usuario > 0 && tipo_usuario < 4);
    const condition = tipo_usuario ? {tipo_usuario: userTypeIsValid ? tipo_usuario : null} : null;
    const {limit, offset} = getPagination(size, page);

    PostulanteModel
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
                    err.message || "Some error occurred while retrieving applicants."
            });
        });

    // other CRUD functions
};
