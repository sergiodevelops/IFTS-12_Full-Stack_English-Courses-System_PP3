import React, {useEffect, useState} from 'react';
import {useDispatch, useSelector} from "react-redux";
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import UsuarioService from "@services/UsuarioService";
import useStyles from "./styles";
import layoutActions from "@redux/actions/layoutActions";
import ICourseCreateResDto
    from "@usecases/course/create/ICourseCreateResDto";
import ICourseCreateReqDto
    from "@usecases/course/create/ICourseCreateReqDto";
import CursoService from "@services/CursoService";
// import { IsNumber, IsString, IsOptional, ValidateNested, IsNotEmpty, ArrayNotEmpty } from "class-validator";

export default function CourseUpdateDeleteForm(props: { row: ICourseCreateResDto }) {

    const title = "Modificar o eliminar";
    const row = props;
    const {
        CodCurso,
        comision,
        CodAula,
        CodDocente,
        CodNivel
    } = props.row as ICourseCreateResDto;

    const cursoService = new CursoService();

    const dispatch = useDispatch();
    // const coursesListStore = useSelector((state) => state?.courseReducers.coursesList);
    const classes = useStyles();
    const emptyCourseModify: ICourseCreateReqDto = {
        comision: "",
        CodAula: 0,
        CodDocente: 0,
        CodNivel: 0,
    }

    const [updateQueryCourse, setUpdateQueryCourse] = useState<ICourseCreateReqDto>(emptyCourseModify);

    const [updateButtonDisable, setUpdateButtonDisable] = useState(false);

    const handleClickReplaceRow = async () => {
        const courseToReplace: ICourseCreateReqDto = {
            comision: updateQueryCourse?.comision, // mapeo para la base, envia un number
            CodAula: !!updateQueryCourse?.CodAula ? updateQueryCourse?.CodAula :  CodAula,
            CodDocente: !!updateQueryCourse?.CodDocente ? updateQueryCourse?.CodDocente :  CodDocente,
            CodNivel: updateQueryCourse?.CodNivel,
        };

        cursoService
            .replace(courseToReplace, CodCurso)
            .then(createdCourse => {
                alert(`La información del curso "${updateQueryCourse.CodAula}" se MODIFICÓ correctamente`);
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
        cursoService
            .delete(CodCurso)
            .then(createdCourse => {
                alert(`La información del curso "${updateQueryCourse.CodAula}" se ELIMINÓ correctamente`);
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
        setUpdateQueryCourse({
            comision,
            CodAula,
            CodDocente,
            CodNivel,
            CodCurso,
        });
    }, [row])


    return (
        <Container className={classes.container} maxWidth="xs">
            <Grid>
                <Grid item xs={12}>
                    <h3 className={classes.titulo}>{title}</h3>
                    <h4 className={classes.titulo}>{`Curso ${updateQueryCourse?.CodCurso} ${updateQueryCourse?.comision}`}</h4>
                </Grid>
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        {/*comision*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`comision`}
                                style={{background: updateQueryCourse.comision !== comision ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={updateQueryCourse?.comision || ""}
                                error={!updateQueryCourse?.comision}
                                onChange={(e) => {
                                    setUpdateQueryCourse({
                                        ...updateQueryCourse,
                                        comision:  e.target.value,
                                    });
                                }}
                                label="DNI"
                                name="comision"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*CodAula*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`CodAula`}
                                style={{background: updateQueryCourse.CodAula !== CodAula ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!updateQueryCourse?.CodDocente}
                                value={!!updateQueryCourse?.CodDocente && updateQueryCourse?.CodAula || ""}
                                error={!!updateQueryCourse?.CodDocente && !updateQueryCourse?.CodAula}
                                onChange={(e) => {
                                    setUpdateQueryCourse({
                                        ...updateQueryCourse,
                                        CodAula:  parseInt(e.target.value),
                                    });
                                }}
                                label="Apellido"
                                name="CodAula"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*CodDocente*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`CodDocente`}
                                style={{background: updateQueryCourse.CodDocente !== CodDocente ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!updateQueryCourse?.CodAula}
                                value={!!updateQueryCourse?.CodAula && updateQueryCourse?.CodDocente || ""}
                                error={!!updateQueryCourse?.CodAula && !updateQueryCourse?.CodDocente}
                                onChange={(e) => {
                                    setUpdateQueryCourse({
                                        ...updateQueryCourse,
                                        CodDocente:  parseInt(e.target.value),
                                    });
                                }}
                                label="Nombres"
                                name="CodAula"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*CodNivel*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`CodNivel`}
                                style={{background: updateQueryCourse.CodNivel !== CodNivel ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!updateQueryCourse?.CodDocente}
                                value={!!updateQueryCourse?.CodDocente && updateQueryCourse?.CodNivel || ""}
                                error={!!updateQueryCourse?.CodDocente && !updateQueryCourse?.CodNivel}
                                onChange={(e) => setUpdateQueryCourse({
                                    ...updateQueryCourse,
                                    CodNivel: parseInt(e.target.value)
                                })}
                                label="Teléfono"
                                size="small"
                                type="CodNivel"
                                name="CodNivelephone"
                                inputProps={{ pattern: "\\([0-9]{3}\\) [0-9]{3}[ -][0-9]{4}" }}
                                title="A valid CodNivelephone number consist of a 3 digits code area between brackets, a space, the three first digits of the number, a space or hypen (-), and four more digits"
                                required
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
