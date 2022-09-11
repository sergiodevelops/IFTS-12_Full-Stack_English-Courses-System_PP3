import React, {useEffect, useRef, useState} from 'react';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import Typography from "@mui/material/Typography";
import IApplicantCreateReqDto from "@usecases/applicant/create/IApplicantCreateReqDto";
import AlumnoService from "@services/AlumnoService";
import useStyles from "./styles";

export default function ApplicantAddForm(props: { title: string }) {
    const alumnoService = new AlumnoService();

    const buttonRef = useRef<HTMLButtonElement>(null);
    const classes = useStyles();
    const emptyApplicant: IApplicantCreateReqDto = {
        apellido: "", dni: 0, email: "", nombres: "", tel: ""
    };
    const [newApplicant, setNewApplicant] = useState<IApplicantCreateReqDto>(emptyApplicant);

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
        setNewApplicant(emptyApplicant);
    }

    const saveApplicant = async () => {
        let message;
        if (
            !newApplicant.dni ||
            !newApplicant.apellido ||
            !newApplicant.nombres ||
            !newApplicant.email ||
            !newApplicant.tel
        ) {
            message = "Por favor complete los campos requeridos";
            alert(message);
            return;
        }
        const newApplicantPost: IApplicantCreateReqDto = {
            apellido: newApplicant.apellido,
            dni: newApplicant.dni,
            email: newApplicant.email,
            nombres: newApplicant.nombres,
            tel: newApplicant.tel,
        };

        alumnoService
            .create(newApplicantPost)
            .then(createdApplicant => {
                console.log("createdApplicant en FE ", createdApplicant);
                alert(`La información de alumno "${newApplicant.nombres} ${newApplicant.apellido}" se persistió correctamente`);
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
                        {/*dni*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`dni`}
                                style={{background: newApplicant.dni ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={newApplicant?.dni || ""}
                                error={!newApplicant?.dni }
                                onChange={(e) => {
                                    setNewApplicant({
                                        ...newApplicant,
                                        dni:  parseInt(e.target.value),
                                    });
                                }}
                                label="DNI"
                                type={"number"}
                                name="dni"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*apellido*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`apellido`}
                                style={{background: newApplicant.apellido ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newApplicant.dni}
                                value={!!newApplicant?.dni && newApplicant?.apellido || ""}
                                error={!!newApplicant?.nombres && !newApplicant?.apellido }

                                onChange={(e) => {
                                    setNewApplicant({
                                        ...newApplicant,
                                        apellido:  e.target.value,
                                    });
                                }}
                                label="Apellido"
                                name="apellido"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*nombres*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`nombres`}
                                style={{background: newApplicant.nombres ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newApplicant?.apellido}
                                value={!!newApplicant?.apellido && newApplicant?.nombres || ""}
                                error={!!newApplicant?.apellido && !newApplicant?.nombres }

                                onChange={(e) => {
                                    setNewApplicant({
                                        ...newApplicant,
                                        nombres:  e.target.value,
                                    });
                                }}
                                label="Nombres"
                                name="apellido"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*tel*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`tel`}
                                style={{background: newApplicant.tel ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newApplicant?.nombres}
                                value={!!newApplicant?.nombres && newApplicant?.tel || ""}
                                error={!!newApplicant?.nombres && !newApplicant?.tel}
                                onChange={(e) => setNewApplicant({
                                    ...newApplicant,
                                    tel:  e.target.value,
                                })}
                                label="Teléfono"
                                name="email"
                                size="small"
                                type="number"
                                variant="outlined"
                            />
                        </Grid>

                        {/*email*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`email`}
                                style={{background: newApplicant.email  ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newApplicant?.tel}
                                value={!!newApplicant?.tel && newApplicant?.email || ""}
                                error={!!newApplicant?.tel && !newApplicant?.email}
                                onChange={(e) => setNewApplicant({
                                    ...newApplicant,
                                    email: e.target.value === "" ? newApplicant.email : e.target.value.toLowerCase()
                                })}
                                label="Correo electrónico"
                                name="email"
                                size="small"
                                type="email"
                                variant="outlined"
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
                                !newApplicant.dni ||
                                !newApplicant.apellido ||
                                !newApplicant.nombres ||
                                !newApplicant.email || 
                                !newApplicant.tel 
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
