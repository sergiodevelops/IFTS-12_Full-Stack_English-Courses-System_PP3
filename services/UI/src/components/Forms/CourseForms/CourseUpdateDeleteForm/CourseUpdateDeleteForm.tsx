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
import FormControl from "@material-ui/core/FormControl";
import Autocomplete from "@material-ui/lab/Autocomplete";
import userTypes from "@constants/userTypes";
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
                    <FormControl variant="outlined"
                                 className={classes.formControl}>
                        <Autocomplete
                            disableClearable
                            className={`CodAula`}
                            disabled={!updateQueryCourse}
                            options={userTypes || []}
                            getOptionLabel={(option) => option.description || ""}
                            onChange={(e: React.ChangeEvent<{}>, selectedOption) => setUpdateQueryCourse({
                                ...updateQueryCourse,
                                CodAula: selectedOption?.id || 0,
                            })}
                            style={{width: 300}}
                            renderInput={(params) =>
                                <TextField
                                    {...params}
                                    error={!updateQueryCourse?.CodAula}
                                    style={{background: updateQueryCourse.CodAula !== CodAula ? '#e8ffe9' : 'inherit'}}
                                    label="Seleccionar una opción"
                                    variant="outlined"
                                />}
                        />
                    </FormControl>
                </Grid>
          <Grid item xs={12}>
                    <FormControl variant="outlined"
                                 className={classes.formControl}>
                        <Autocomplete
                            disableClearable
                            className={`docente`}
                            disabled={!updateQueryCourse}
                            options={userTypes || []}
                            getOptionLabel={(option) => option.description || ""}
                            onChange={(e: React.ChangeEvent<{}>, selectedOption) => setUpdateQueryCourse({
                                ...updateQueryCourse,
                                CodDocente: selectedOption?.id || 0,
                            })}
                            style={{width: 300}}
                            renderInput={(params) =>
                                <TextField
                                    {...params}
                                    error={!updateQueryCourse?.CodDocente}
                                    style={{background: updateQueryCourse.CodDocente !== CodDocente ? '#e8ffe9' : 'inherit'}}
                                    label="Seleccionar una opción"
                                    variant="outlined"
                                />}
                        />
                    </FormControl>
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
