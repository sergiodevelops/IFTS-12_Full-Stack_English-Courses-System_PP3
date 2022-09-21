const PersonaModel = require('../models').Persona;

function index(req,res) {
    PersonaModel.findAll()
        .then((persona) => {
            return res.status(200).json(persona)
        })
        .catch((error) => {
            return res.status(400).json(error)
        });
}

function create(req,res) {
    PersonaModel.create({
        documento: req.body.documento,
        nombre: req.body.nombre,
        apellido: req.body.apellido,
        IdUsuario: req.body.IdUsuario
    })
        .then((persona) => {
            return res.status(200).json(persona)
        })
        .catch((error) => {
            return res.status(400).json(error)
        });
}
/*
function show(req,res) {
    PersonaModel.findById(req.params.id)
        .then((passport) => {
            if (!passport) {
                return res.status(404).json({ message: 'Persona Not Found' });
            }

            return res.status(200).json(passport);
        })
        .catch((error) => {
            return res.status(400).json(error)
        });
}

function update(req,res) {
    PersonaModel.findById(req.params.id)
        .then((passport) => {
            if (!passport) {
                return res.status(404).json({ message: 'Persona Not Found' });
            }

            passport.update({
                ...passport, //spread out existing passport
                ...req.body //spread out req.body - the differences in the body will override the passport returned from DB.
            })
                .then((updatedPersona) => {
                    return res.status(200).json(updatedPersona)
                })
                .catch((error) => {
                    return res.status(400).json(error)
                });
        })
        .catch((error) => {
            return res.status(400).json(error)
        });
}

function destroy(req,res) {
    PersonaModel.findById(req.params.id)
        .then((passport) => {
            if (!passport) {
                return res.status(400).json({ message: 'Persona Not Found' });
            }
            passport.destroy()
                .then((passport) => {
                    return res.status(200).json(passport)
                })
                .catch((error) => {
                    return res.status(400).json(error)
                });
        })
        .catch((error) => {
            return res.status(400).json(error)
        });
}*/

module.exports = { index, create, show, update, destroy }