
const AnuncioModel = require('../models').Anuncio;

const getPagination = (size, page) => {
    const limit = size ? +size : 10;
    const offset = page ? page * limit : 0;

    return {limit, offset};
};

const getPagingData = (data, page, limit) => {
    const {count: totalItems, rows: news} = data;
    const currentPage = page ? +page : 0;
    const totalPages = Math.ceil(totalItems / limit);

    return {totalItems, news, totalPages, currentPage};
};

// CREA ANUNCIO (alta)
exports.create = (req, res) => {
    // Validate "titulo"
    if (!req.body.titulo) {
        res.status(400).send({
            message: "Debe enviar un 'titulo' para crear el News!"
        });
        return;
    }
    // Validate "descripcion"
    if (!req.body.descripcion) {
        res.status(400).send({
            message: "Debe enviar un 'descripcion' para crear el News!"
        });
        return;
    }
    // Create a News
    const newDbNews = {
        titulo: req.body.titulo,
        descripcion: req.body.descripcion,
    };

    AnuncioModel
        .create(newDbNews, {})
        .then(data => {
            res.status(201).send(data);
        })
        .catch(err => {
            res.status(409).send({
                name: "Duplicate News Entry",
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
            if (num == 1 || num == 0) {
                res.send({
                    message: "News was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update Tutorial with id=${id}. Maybe News was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating News with id=" + id
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
                    message: `News was deleted successfully! ID=${id}`,
                });
            } else {
                res.send({
                    message: `Cannot delete News with ID=${id}. Maybe News was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: `Could not delete News with ID=${id}`,
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
                    err.message || "Some error occurred while retrieving news."
            });
        });

    // other CRUD functions
};
