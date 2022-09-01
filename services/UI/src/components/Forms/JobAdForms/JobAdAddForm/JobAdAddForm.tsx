import React, {useEffect, useRef, useState} from 'react';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import useStyles from "./styles";
import Typography from "@mui/material/Typography";
import IJobAdCreateReqDto
    from "@usecases/jobad/create/IJobAdCreateReqDto";
import AnuncioService from "@services/AnuncioService";

export default function ApplicantAddForm(props: { title: string }) {
    const jobAdService = new AnuncioService();

    const buttonRef = useRef<HTMLButtonElement>(null);
    const classes = useStyles();
    const emptyApplicant: IJobAdCreateReqDto = {
        descripcion_tareas: "",
        estudios: "",
        experiencia: "",
        puesto_vacante: "",
    };
    const [newJobAd, setNewJobAd] = useState<IJobAdCreateReqDto>(emptyApplicant);

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
            !newJobAd.puesto_vacante ||
            !newJobAd.descripcion_tareas ||
            !newJobAd.experiencia ||
            !newJobAd.estudios
        ) {
            message = "Por favor complete los campos requeridos";
            alert(message);
            return;
        }
        const newJobAdPost: IJobAdCreateReqDto = {
            puesto_vacante: newJobAd.puesto_vacante,
            descripcion_tareas: newJobAd.descripcion_tareas,
            estudios: newJobAd.estudios,
            experiencia: newJobAd.experiencia,
        };

        jobAdService
            .create(newJobAdPost)
            .then(createdApplicant => {
                console.log("createdApplicant en FE ", createdApplicant);
                alert(`El anuncio para "${newJobAd.puesto_vacante}" se persistió correctamente`);
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
                        {/*puesto_vacante*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`puesto_vacante`}
                                style={{background: newJobAd.puesto_vacante ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={newJobAd?.puesto_vacante || ""}
                                error={!newJobAd?.puesto_vacante}

                                onChange={(e) => {
                                    setNewJobAd({
                                        ...newJobAd,
                                        puesto_vacante: e.target.value,
                                    });
                                }}
                                label="Puesto vacante"
                                type="text"
                                name="puesto_vacante"
                                size="small"
                                variant="outlined"
                                multiline
                            />
                        </Grid>

                        {/*descripcion_tareas*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`descripcion_tareas`}
                                style={{background: newJobAd.descripcion_tareas ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newJobAd.puesto_vacante}
                                value={!!newJobAd?.puesto_vacante && newJobAd?.descripcion_tareas || ""}
                                error={!!newJobAd?.puesto_vacante && !newJobAd?.descripcion_tareas}

                                onChange={(e) => {
                                    setNewJobAd({
                                        ...newJobAd,
                                        descripcion_tareas: e.target.value,
                                    });
                                }}
                                label="Descripción de tareas"
                                type="text"
                                name="descripcion_tareas"
                                size="small"
                                variant="outlined"
                                multiline
                            />
                        </Grid>

                        {/*experiencia*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`experiencia`}
                                style={{background: newJobAd.experiencia ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newJobAd?.descripcion_tareas}
                                value={!!newJobAd?.descripcion_tareas && newJobAd?.experiencia || ""}
                                error={!!newJobAd?.descripcion_tareas && !newJobAd?.experiencia}

                                onChange={(e) => {
                                    setNewJobAd({
                                        ...newJobAd,
                                        experiencia: e.target.value,
                                    });
                                }}
                                label="Experiencia"
                                name="apellido"
                                size="small"
                                variant="outlined"
                                multiline
                            />
                        </Grid>

                        {/*estudios*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`estudios`}
                                style={{background: newJobAd.estudios ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newJobAd?.experiencia}
                                value={!!newJobAd?.experiencia && newJobAd?.estudios || ""}
                                error={!!newJobAd?.experiencia && !newJobAd?.estudios}
                                onChange={(e) => setNewJobAd({
                                    ...newJobAd,
                                    estudios: e.target.value,
                                })}
                                label="Estudios"
                                name="email"
                                size="small"
                                type="text"
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
                                !newJobAd.puesto_vacante ||
                                !newJobAd.descripcion_tareas ||
                                !newJobAd.experiencia ||
                                !newJobAd.estudios
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
