import React, {useEffect, useState} from 'react';
import {useDispatch} from "react-redux";
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import useStyles from "./styles";
import layoutActions from "@redux/actions/layoutActions";
import INewCreateResDto
    from "@usecases/new/create/INewCreateResDto";
import AnuncioService from "@services/AnuncioService";
import INewsCreateReqDto
    from "@usecases/new/create/INewsCreateReqDto";

export default function JobAdUpdateDeleteForm(props: { row: INewCreateResDto }) {
    const title = "Modificar o eliminar";
    const row = props;
    const {
        id, titulo, descripcion
    } = props.row as INewCreateResDto;

    const anuncioService = new AnuncioService();

    const dispatch = useDispatch();

    const classes = useStyles();
    const emptyJobAdModify = {
        titulo: "",
        descripcion: "",
    }

    const [updateQueryJobAd, setUpdateQueryJobAd] = useState<any>(emptyJobAdModify);

    const [updateButtonDisable, setUpdateButtonDisable] = useState(false);

    const handleClickReplaceRow = async () => {

        const jobAdToReplace: any = {
            titulo: updateQueryJobAd.titulo,
            descripcion: updateQueryJobAd.descripcion,
        };

        anuncioService
            .replace(jobAdToReplace, id)
            .then(createdJobAd => {
                alert(`El anuncio para "${updateQueryJobAd.titulo}" se MODIFICÓ correctamente`);
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
                alert(`El anuncio para "${updateQueryJobAd.titulo}" se ELIMINÓ correctamente`);
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
            titulo,
            descripcion,
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
                        {/*titulo*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`titulo`}
                                // style={{background: updateQueryJobAd.titulo !== titulo ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryJobAd?.titulo || ""}
                                error={!updateQueryJobAd?.titulo}
                                onChange={(e) => setUpdateQueryJobAd({
                                    ...updateQueryJobAd,
                                    titulo: e.target.value === "" ? titulo : e.target.value,
                                })}
                                label="Titulo"
                                name="titulo"
                                size="small"
                                type="text"
                                variant="outlined"
                            />
                        </Grid>
                        {/*descripcion*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`descripcion`}
                                // style={{background: updateQueryJobAd.descripcion !== descripcion ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryJobAd?.descripcion || ""}
                                error={!updateQueryJobAd?.descripcion}
                                onChange={(e) => setUpdateQueryJobAd({
                                    ...updateQueryJobAd,
                                    descripcion: e.target.value === "" ? descripcion : e.target.value,
                                })}
                                label="Descripcion tareas"
                                name="descripcion"
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
