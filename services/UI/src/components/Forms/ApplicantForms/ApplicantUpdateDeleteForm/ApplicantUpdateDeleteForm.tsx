import React, {useEffect, useState} from 'react';
import {useDispatch, useSelector} from "react-redux";
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import UsuarioService from "@services/UsuarioService";
import useStyles from "./styles";
import layoutActions from "@redux/actions/layoutActions";
import IApplicantCreateResDto
    from "@usecases/applicant/create/IApplicantCreateResDto";
import IApplicantCreateReqDto
    from "@usecases/applicant/create/IApplicantCreateReqDto";
import AlumnoService from "@services/AlumnoService";
// import { IsNumber, IsString, IsOptional, ValidateNested, IsNotEmpty, ArrayNotEmpty } from "class-validator";

export default function ApplicantUpdateDeleteForm(props: { row: IApplicantCreateResDto }) {

    const title = "Modificar o eliminar";
    const row = props;
    const {
        id,
        dni,
        apellido,
        nombres,
        tel,
        email,
    } = props.row as IApplicantCreateResDto;

    const alumnoService = new AlumnoService();

    const dispatch = useDispatch();
    // const applicantsListStore = useSelector((state) => state?.applicantReducers.applicantsList);
    const classes = useStyles();
    const emptyApplicantModify: IApplicantCreateReqDto = {
        dni: 0,
        apellido: "",
        nombres: "",
        tel: "",
        email: "",
    }

    const [updateQueryApplicant, setUpdateQueryApplicant] = useState<IApplicantCreateReqDto>(emptyApplicantModify);

    const [updateButtonDisable, setUpdateButtonDisable] = useState(false);

    const handleClickReplaceRow = async () => {
        const applicantToReplace: IApplicantCreateReqDto = {
            dni: updateQueryApplicant?.dni, // mapeo para la base, envia un number
            apellido: !!updateQueryApplicant?.apellido ? updateQueryApplicant?.apellido :  apellido,
            nombres: !!updateQueryApplicant?.nombres ? updateQueryApplicant?.nombres :  nombres,
            tel: updateQueryApplicant?.tel,
            email: updateQueryApplicant?.email,
        };

        alumnoService
            .replace(applicantToReplace, id)
            .then(createdApplicant => {
                console.log("createdApplicant en FE ", createdApplicant);
                alert(`La información del alumno "${updateQueryApplicant.apellido}" se MODIFICÓ correctamente`);
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
        alumnoService
            .delete(id)
            .then(createdApplicant => {
                alert(`La información del alumno "${updateQueryApplicant.apellido}" se ELIMINÓ correctamente`);
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
        setUpdateQueryApplicant({
            dni,
            apellido,
            nombres,
            tel,
            email,
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
                        {/*dni*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`dni`}
                                style={{background: updateQueryApplicant.dni !== dni ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryApplicant?.dni || ""}
                                error={!updateQueryApplicant?.dni}
                                onChange={(e) => {
                                    setUpdateQueryApplicant({
                                        ...updateQueryApplicant,
                                        dni:  parseInt(e.target.value),
                                    });
                                }}
                                label="DNI"
                                name="dni"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*apellido*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`apellido`}
                                style={{background: updateQueryApplicant.apellido !== apellido ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!updateQueryApplicant?.nombres}
                                value={!!updateQueryApplicant?.nombres && updateQueryApplicant?.apellido || ""}
                                error={!!updateQueryApplicant?.nombres && !updateQueryApplicant?.apellido}
                                onChange={(e) => {
                                    setUpdateQueryApplicant({
                                        ...updateQueryApplicant,
                                        apellido:  e.target.value === "" ? apellido : e.target.value,
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
                                style={{background: updateQueryApplicant.nombres !== nombres ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!updateQueryApplicant?.apellido}
                                value={!!updateQueryApplicant?.apellido && updateQueryApplicant?.nombres || ""}
                                error={!!updateQueryApplicant?.apellido && !updateQueryApplicant?.nombres}
                                onChange={(e) => {
                                    setUpdateQueryApplicant({
                                        ...updateQueryApplicant,
                                        nombres:  e.target.value === "" ? nombres : e.target.value,
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
                                style={{background: updateQueryApplicant.tel !== tel ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!updateQueryApplicant?.nombres}
                                value={!!updateQueryApplicant?.nombres && updateQueryApplicant?.tel || ""}
                                error={!!updateQueryApplicant?.nombres && !updateQueryApplicant?.tel}
                                onChange={(e) => setUpdateQueryApplicant({
                                    ...updateQueryApplicant,
                                    tel: e.target.value === "" ? tel : e.target.value.toLowerCase()
                                })}
                                label="Teléfono"
                                size="small"
                                type="tel"
                                name="telephone"
                                inputProps={{ pattern: "\\([0-9]{3}\\) [0-9]{3}[ -][0-9]{4}" }}
                                title="A valid telephone number consist of a 3 digits code area between brackets, a space, the three first digits of the number, a space or hypen (-), and four more digits"
                                required
                                variant="outlined"
                            />
                        </Grid>

                        {/*email*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`email`}
                                style={{background: updateQueryApplicant.email !== email ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!updateQueryApplicant?.tel}
                                value={!!updateQueryApplicant?.tel && updateQueryApplicant?.email || ""}
                                error={!!updateQueryApplicant?.tel && !updateQueryApplicant?.email}
                                onChange={(e) => setUpdateQueryApplicant({
                                    ...updateQueryApplicant,
                                    email: e.target.value === "" ? email : e.target.value.toLowerCase()
                                })}
                                label="Correo electrónico"
                                name="email"
                                inputProps={{ pattern: "[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" }}
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
