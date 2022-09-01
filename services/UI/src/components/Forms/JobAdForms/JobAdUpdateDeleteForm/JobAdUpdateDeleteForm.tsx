import React, {useEffect, useState} from 'react';
import {useDispatch} from "react-redux";
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import useStyles from "./styles";
import layoutActions from "@redux/actions/layoutActions";
import IJobAdCreateResDto
    from "@usecases/jobad/create/IJobAdCreateResDto";
import AnuncioService from "@services/AnuncioService";
import IJobAdCreateReqDto
    from "@usecases/jobad/create/IJobAdCreateReqDto";

export default function JobAdUpdateDeleteForm(props: { row: IJobAdCreateResDto }) {
    const title = "Modificar o eliminar";
    const row = props;
    const {
        id, descripcion_tareas, experiencia, puesto_vacante, estudios
    } = props.row as IJobAdCreateResDto;

    const anuncioService = new AnuncioService();

    const dispatch = useDispatch();

    const classes = useStyles();
    const emptyJobAdModify: IJobAdCreateReqDto = {
        descripcion_tareas: "",
        estudios: "",
        experiencia: "",
        puesto_vacante: "",
    }

    const [updateQueryJobAd, setUpdateQueryJobAd] = useState<IJobAdCreateReqDto>(emptyJobAdModify);

    const [updateButtonDisable, setUpdateButtonDisable] = useState(false);

    const handleClickReplaceRow = async () => {

        const jobAdToReplace: IJobAdCreateReqDto = {
            descripcion_tareas: updateQueryJobAd?.descripcion_tareas, // mapeo para la base, envia un number
            estudios: updateQueryJobAd?.estudios,
            experiencia: updateQueryJobAd?.experiencia,
            puesto_vacante: updateQueryJobAd?.puesto_vacante,
        };

        anuncioService
            .replace(jobAdToReplace, id)
            .then(createdJobAd => {
                console.log("createdJobAd en FE ", createdJobAd);
                alert(`El anuncio para "${updateQueryJobAd.puesto_vacante}" se MODIFICÓ correctamente`);
                dispatch(layoutActions.setOpenModal(false));
            })
            .catch(err => {
                err.then((err: Error) => {
                        console.error("ERROR en FE", err.message);
                        alert(`${err.message}`);
                        dispatch(layoutActions.setOpenModal(false));
                    }
                )
            });
    };

    const handleClickDeleteRow = async () => {
        anuncioService
            .delete(id)
            .then(createdJobAd => {
                // console.log("createdJobAd en FE ", createdJobAd);
                alert(`El anuncio para "${updateQueryJobAd.puesto_vacante}" se ELIMINÓ correctamente`);
                dispatch(layoutActions.setOpenModal(false));
            })
            .catch(err => {
                err.then((err: Error) => {
                        console.error("ERROR en FE", err.message);
                        alert(`${err.message}`);
                        dispatch(layoutActions.setOpenModal(false));
                    }
                )
            });
    };

    useEffect(() => {
        // !!currentOriginalJobAd && setOriginalJobAd(currentOriginalJobAd);
        setUpdateQueryJobAd({
            descripcion_tareas,
            estudios,
            experiencia,
            puesto_vacante,
        });
    }, [row])

    return (
        <Container className={classes.container} maxWidth="xs">
            <Grid>
                <Grid item xs={12}>
                    <h3 className={classes.titulo}>{title}</h3>
                </Grid>
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        {/*puesto_vacante*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`puesto_vacante`}
                                // style={{background: updateQueryJobAd.puesto_vacante !== puesto_vacante ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryJobAd?.puesto_vacante || ""}
                                error={!updateQueryJobAd?.puesto_vacante}
                                onChange={(e) => setUpdateQueryJobAd({
                                    ...updateQueryJobAd,
                                    puesto_vacante: e.target.value === "" ? puesto_vacante : e.target.value,
                                })}
                                label="Puesto vacante"
                                name="puesto_vacante"
                                size="small"
                                type="text"
                                variant="outlined"
                            />
                        </Grid>
                        {/*descripcion_tareas*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`descripcion_tareas`}
                                // style={{background: updateQueryJobAd.descripcion_tareas !== descripcion_tareas ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryJobAd?.descripcion_tareas || ""}
                                error={!updateQueryJobAd?.descripcion_tareas}
                                onChange={(e) => setUpdateQueryJobAd({
                                    ...updateQueryJobAd,
                                    descripcion_tareas: e.target.value === "" ? descripcion_tareas : e.target.value,
                                })}
                                label="Descripcion tareas"
                                name="descripcion_tareas"
                                size="small"
                                type="text"
                                variant="outlined"
                            />
                        </Grid>
                        {/*experiencia*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`experiencia`}
                                // style={{background: updateQueryJobAd.experiencia !== experiencia ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryJobAd?.experiencia || ""}
                                error={!updateQueryJobAd?.experiencia}
                                onChange={(e) => setUpdateQueryJobAd({
                                    ...updateQueryJobAd,
                                    experiencia: e.target.value === "" ? experiencia : e.target.value,
                                })}
                                label="Experiencia"
                                name="experiencia"
                                size="small"
                                type="text"
                                variant="outlined"
                            />
                        </Grid>
                        {/*estudios*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`estudios`}
                                // style={{background: updateQueryJobAd.estudios !== estudios ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryJobAd?.estudios || ""}
                                error={!updateQueryJobAd?.estudios}
                                onChange={(e) => setUpdateQueryJobAd({
                                    ...updateQueryJobAd,
                                    estudios: e.target.value === "" ? estudios : e.target.value,
                                })}
                                label="Estudios"
                                name="estudios"
                                size="small"
                                type="text"
                                variant="outlined"
                            />
                        </Grid>
                    </Grid>
                </Grid>

                <Grid container spacing={3}>
                    <Grid item xs={12}>
                        <Button
                            color={"primary"}
                            fullWidth type="submit" variant="contained"
                            onClick={handleClickReplaceRow}
                            disabled={updateButtonDisable}
                        >
                            modificar
                        </Button>
                    </Grid>
                    <Grid item xs={12}>
                        <Button
                            color={"secondary"}
                            fullWidth type="submit" variant="contained"
                            onClick={handleClickDeleteRow}
                        >
                            eliminar
                        </Button>
                    </Grid>
                </Grid>
            </Grid>
        </Container>
    );
};
