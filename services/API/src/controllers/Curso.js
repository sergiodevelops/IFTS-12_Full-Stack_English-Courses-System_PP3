const CursoModel = require('../models').Curso;
const {Aula, usuarios, Idioma} = require('../models');

const getPagination = (size, page) => {
    const limit = size ? +size : 10;
    const offset = page ? page * limit : 0;
    return {limit, offset};
};

const getPagingData = (data, page, limit) => {
    const {count: totalItems, rows: courses} = data;
    const currentPage = page ? +page : 0;
    const totalPages = Math.ceil(totalItems / limit);
    return {totalItems, courses, totalPages, currentPage};
};

// ALTA (crea nuevo curso)
exports.create = (req, res) => {
    if (!req.body.CodNivel) {
        res.status(400).send({
            message: "Debe enviar un 'CodNivel' para crear el Curso!"
        });
        return;
    }
    if (!req.body.comision) {
        res.status(400).send({
            message: "Debe enviar un 'comision' para crear el Curso!"
        });
        return;
    }

    // Create a Curso
    const newCourse = {
        CodNivel: req.body.CodNivel,
        comision: req.body.comision
    };

    // Save Curso in the database if "CodCurso" not exist
    CursoModel
        .create(newCourse)
        .then(data => {
            res.status(201).send(data);
        })
        .catch(err => {
            res.status(409).send({
                name: "Duplicate Course Entry",
                message: `${err}`
                // message: `El CodCurso "${req.body.CodNivel}" ya existe, intente con uno diferente.`
            });
        });
};

// MODIFICACIÓN DE CURSO TOTAL (actualización)
exports.replace = (req, res) => {
    const {id} = req.query;

    CursoModel
        .update(
            req.body,
            {where: {CodCurso: id}})
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "Course was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update Tutorial with id=${id}. Maybe Course was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating Course with id=" + id
            });
        });
};

// BAJA (elimina el CURSO)
exports.delete = (req, res) => {
    const {id} = req.query;

    CursoModel.destroy({
        where: {CodCurso: id}
    })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "Course was deleted successfully!" + id
                });
            } else {
                res.send({
                    message: `Cannot delete Course with id=${id}. Maybe Course was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete Course with id=" + id
            });
        });
};

// CONSULTA (obtiene los CURSOS segun filtros)
exports.findAllByFilters = (req, res) => {
    let {size, page, CodCurso} = req.query;
    const userTypeIsValid = (CodCurso > 0 && CodCurso < 4);
    const condition = CodCurso ? {CodCurso: userTypeIsValid ? CodCurso : null} : null;
    const {limit, offset} = getPagination(size, page);

    CursoModel
        .findAndCountAll({
            where: condition, 
            include: [{
                model: Aula,
            }, {
                model: usuarios,
                as: 'Docente',
                attributes: ['nombre_completo']
            }, {
                model: Idioma,
                attributes: ['nombre']
            }],
            attributes: {
                exclude: [
                    'CodAula',
                    'CodDocente',
                    'CodIdioma'
                ]
            },
            raw: true,
            limit, offset})
        .then(data => {
            const response = getPagingData(data, page, limit);
            res.send(response);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving courses."
            });
        });
};
