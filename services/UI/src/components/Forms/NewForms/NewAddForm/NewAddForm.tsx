import React, {useEffect, useRef, useState} from 'react';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import useStyles from "./styles";
import Typography from "@mui/material/Typography";
import INewsCreateReqDto
    from "@usecases/new/create/INewsCreateReqDto";
import AnuncioService from "@services/AnuncioService";

export default function NewAddForm(props: { title: string }) {
    const jobAdService = new AnuncioService();

    const buttonRef = useRef<HTMLButtonElement>(null);
    const classes = useStyles();
    const emptyApplicant: INewsCreateReqDto = {
        titulo: "",
        descripcion: "",
    };
    const [newJobAd, setNewJobAd] = useState<INewsCreateReqDto>(emptyApplicant);

    useEffect(() => {
        const listener = (event: KeyboardEvent) => {
            if (event.code === "Enter" || event.code === "NumpadEnter") {
                event.preventDefault();
                buttonRef?.current?.click();
            }
        };
        document.addEventListener("keyup", listener);
        return () => document.removeEventListener("keyup", listener);
    }, [buttonRef]);

    const cleanInputValues = () => {
        setNewJobAd(emptyApplicant);
    }

    const saveApplicant = async () => {
        let message;
        if (
            !newJobAd.titulo ||
            !newJobAd.descripcion
        ) {
            message = "Por favor complete los campos requeridos";
            alert(message);
            return;
        }
        const newJobAdPost: INewsCreateReqDto = {
            titulo: newJobAd.titulo,
            descripcion: newJobAd.descripcion
        };

        jobAdService
            .create(newJobAdPost as INewsCreateReqDto)
            .then(createdApplicant => {
                alert(`El anuncio para "${newJobAd.titulo}" se persistió correctamente`);
                cleanInputValues();
            })
            .catch(err => {
                err.then((err: Error) => {
                        console.error("ERROR en FE", err.message);
                        alert(`${err.message}`);
                    }
                )
            });
    };

    return (
        <Grid container>
            <Grid item xs={12}>
                <Typography variant={"h4"}
                            noWrap
                            className={classes.addFormTitle}
                            component={"div"}
                            textAlign={'center'}
                            marginY={'2vh'}
                >
                    {props?.title}
                </Typography>
                {/*<h1 className={classes.titulo}>{props?.title || "Alta de registro"}</h1>*/}
            </Grid>

            <Container className={classes.root} maxWidth="xs">
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        {/*titulo*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`titulo`}
                                style={{background: newJobAd.titulo ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={newJobAd?.titulo || ""}
                                error={!newJobAd?.titulo}

                                onChange={(e) => {
                                    setNewJobAd({
                                        ...newJobAd,
                                        titulo: e.target.value,
                                    });
                                }}
                                label="Título"
                                type="text"
                                name="titulo"
                                size="small"
                                variant="outlined"
                                multiline
                            />
                        </Grid>

                        {/*descripcion*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`descripcion_tareas`}
                                style={{background: newJobAd.descripcion ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newJobAd.titulo}
                                value={!!newJobAd?.titulo && newJobAd?.descripcion || ""}
                                error={!!newJobAd?.titulo && !newJobAd?.descripcion}

                                onChange={(e) => {
                                    setNewJobAd({
                                        ...newJobAd,
                                        descripcion: e.target.value,
                                    });
                                }}
                                label="Descripción del anuncio"
                                type="text"
                                name="descripcion_tareas"
                                size="small"
                                variant="outlined"
                                multiline
                            />
                        </Grid>
                    </Grid>
                </Grid>

                <Grid container spacing={3}>
                    <Grid item xs={12}>
                        <Button
                            ref={buttonRef}
                            autoFocus={true}
                            color={"primary"}
                            fullWidth type="submit" variant="contained"
                            disabled={
                                !newJobAd.titulo ||
                                !newJobAd.descripcion
                            }
                            onClick={saveApplicant}
                        >
                            crear
                        </Button>
                    </Grid>
                </Grid>
            </Container>
        </Grid>
    );
};
