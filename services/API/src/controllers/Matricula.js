const MatriculaModel = require('../models').Matricula;
const {Curso, usuarios } = require('../models');

const getPagination = (size, page) => {
    const limit = size ? +size : 10;
    const offset = page ? page * limit : 0;
    return {limit, offset};
};

const getPagingData = (data, page, limit) => {
    const {count: totalItems, rows: matriculas} = data;
    const currentPage = page ? +page : 0;
    const totalPages = Math.ceil(totalItems / limit);
    return {totalItems, matriculas, totalPages, currentPage};
};

// ALTA (crea nuevo Matricula)
exports.create = (req, res) => {
    if (!req.body.CodCurso) {
        res.status(400).send({
            message: "Debe enviar un 'CodCurso' para crear el Matricula!"
        });
        return;
    }
    if (!req.body.Legajo) {
        res.status(400).send({
            message: "Debe enviar un 'Legajo' para crear el Matricula!"
        });
        return;
    }

    // Create a Matricula
    const newMatricula = {
        CodCurso: req.body.CodCurso,
        Legajo: req.body.Legajo
    };

    // Save Matricula in the database if "CodMatricula" not exist
    MatriculaModel
        .create(newMatricula)
        .then(data => {
            res.status(201).send(data);
        })
        .catch(err => {
            res.status(409).send({
                name: "Duplicate Matricula Entry",
                message: "Este alumno ya se encuentra matrículado al curso"
            });
        });
};

// MODIFICACIÓN DE Matricula TOTAL (actualización)
exports.replace = (req, res) => {
    const {id} = req.query;

    MatriculaModel
        .update(
            req.body,
            {where: {IdMatricula: id}})
        .then(num => {
            if (num == 1 || num == 0) {
                res.send({
                    message: "Matricula was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update Tutorial with id=${id}. Maybe Matricula was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating Matricula with id=" + id + err
            });
        });
};

// BAJA (elimina el Matricula)
exports.delete = (req, res) => {
    const {id} = req.query;

    MatriculaModel.destroy({
        where: {IdMatricula: id}
    })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "Matricula was deleted successfully!" + id
                });
            } else {
                res.send({
                    message: `Cannot delete Matricula with id=${id}. Maybe Matricula was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete Matricula with id=" + id
            });
        });
};

// CONSULTA (obtiene los MatriculaS segun filtros)
exports.findAllByFilters = (req, res) => {
    let {size, page, CodMatricula} = req.query;
    const userTypeIsValid = (CodMatricula > 0 && CodMatricula < 4);
    const condition = CodMatricula ? {CodMatricula: userTypeIsValid ? CodMatricula : null} : null;
    const {limit, offset} = getPagination(size, page);

    MatriculaModel
        .findAndCountAll({
            where: condition, 
            include: [{
                model: Curso,
            }, {
                model: usuarios,
                as: 'Alumno',
                attributes: ['nombre_completo']
            }],
            attributes: {
                exclude: [
                    'CodCurso',
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
                    err.message || "Some error occurred while retrieving matriculas."
            });
        });
};
