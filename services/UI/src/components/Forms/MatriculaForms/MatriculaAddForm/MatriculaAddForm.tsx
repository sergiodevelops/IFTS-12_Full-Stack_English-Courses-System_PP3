import React, {Fragment, useEffect, useRef, useState} from 'react';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import useStyles from "./styles";
import Typography from "@mui/material/Typography";
import IMatriculaCreateReqDto from "@usecases/matricula/create/IMatriculaCreateReqDto";
import FormControl from "@material-ui/core/FormControl";
import Autocomplete from "@material-ui/lab/Autocomplete";
import CircularProgress from "@mui/material/CircularProgress";
import IPaginationSetDto from "@usecases/pagination/set/IPaginationSetDto";
import IUserFindResDto from "@usecases/user/find/IUserFindResDto";
import IUserCreateResDto from "@usecases/user/create/IUserCreateResDto";
import ICoursesFindResDto from "@usecases/course/find/ICoursesFindResDto";
import ICourseCreateResDto from "@usecases/course/create/ICourseCreateResDto";
import IFilterSetDto from "@usecases/filter/add/IFilterSetDto";
import UsuarioService from "@services/UsuarioService";
import MatriculaService from "@services/MatriculaService";
import CursoService from "@services/CursoService";
import IMatriculaCreateResDto
    from "@usecases/matricula/create/IMatriculaCreateResDto";

export default function MatriculaAddForm(props: { title: string }) {
    const matriculaAddService = new MatriculaService();

    const buttonRef = useRef<HTMLButtonElement>(null);
    const classes = useStyles();
    const emptyMatricula: IMatriculaCreateReqDto = {
        CodCurso: 0,
        Legajo: 0,
    };
    const [newMatricula, setNewMatricula] = useState<IMatriculaCreateReqDto>(emptyMatricula);

    const [cursos, setCursos] = useState<(ICourseCreateResDto)[]>([]);

    const [alumnos, setAlumnos] = useState<(IUserCreateResDto)[]>([]);

    const [queryCursoInProgress, setQueryCursoInProgress] = useState<boolean>(false);
    const [queryDocenteInProgress, setQueryDocenteInProgress] = useState<boolean>(false);


    useEffect(() => {
        const newPagination = {size: 10, page: 0};
        getCursos(newPagination);
        getAlumnos(newPagination);
    }, []);

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
        setCursos([]);
        setAlumnos([]);
        setNewMatricula(emptyMatricula);
    }

    const saveMatricula = async () => {
        let message;
        if (
            !newMatricula.CodCurso ||
            !newMatricula.Legajo
        ) {
            message = "Por favor complete los campos requeridos";
            alert(message);
            return;
        }
        const newMatriculaPost: IMatriculaCreateReqDto = {
            CodCurso: newMatricula.CodCurso,
            Legajo: newMatricula.Legajo,
        };

        matriculaAddService
            .create(newMatriculaPost as IMatriculaCreateReqDto)
            .then((createdMatricula: IMatriculaCreateResDto) => {
                console.log("createdMatricula", createdMatricula)
                alert(`Se matriculó exitosamente al alumno"`);
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

    const getCursos = async(
        pagination: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const cursoService = new CursoService();
        setQueryCursoInProgress(true);

        let response: ICoursesFindResDto ;
        response = await cursoService.findAllByFilters(pagination, filters);
        if(!response) throw Error("No llego info en primer lista");

        let cursos = response.courses;
        const {totalPages, currentPage} = response;
        if(totalPages > 1){
            for(let i = currentPage; i < totalPages - 1; i++){
                pagination = {...pagination, page: i + 1};
                response = await cursoService.findAllByFilters(pagination, filters);
                if(!response) throw Error("No llego info en el for");
                cursos = [...cursos, ...response.courses];
            }
        }
        setCursos(cursos);
        setQueryCursoInProgress(false);
    }

    const getAlumnos = async(
        pagination: IPaginationSetDto,
    ) => {
        setQueryDocenteInProgress(true);

        const userService = new UsuarioService();

        let response: IUserFindResDto ;
        const alumnosFilter = [{key: 'tipo_usuario', value: '3'}];

        response = await userService.findAllByFilters(pagination, alumnosFilter);
        if(!response) throw Error("No llego info en primer lista");

        let alumnos = response.users;
        const {totalPages, currentPage} = response;
        if(totalPages > 1){
            for(let i = currentPage; i < totalPages - 1; i++){
                pagination = {...pagination, page: i + 1};
                response = await userService.findAllByFilters(pagination, alumnosFilter);
                if(!response) throw Error("No llego info en el for");
                alumnos = [...alumnos, ...response.users];
            }
        }
        setAlumnos(alumnos);
        setQueryDocenteInProgress(false);
    }

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
                {/*<h1 className={classes.CodNivel}>{props?.title || "Alta de registro"}</h1>*/}
            </Grid>

            <Container className={classes.root} maxWidth="xs">
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        {/*matricula input 1*/}
                        <Grid item xs={12}>
                            <FormControl variant="outlined" className={classes.formControl}>
                                <Autocomplete
                                    disableClearable
                                    className={`CodCurso`}
                                    options={cursos}
                                    getOptionLabel={(option) => `Curso: ${option.CodCurso} | Comisión: ${option.comision}`|| ""}
                                    onChange={(e: React.ChangeEvent<{}>, selectedOption) => setNewMatricula({
                                        ...newMatricula,
                                        CodCurso: selectedOption?.CodCurso || 0,
                                    })}
                                    style={{width: 300}}
                                    renderInput={(params) =>
                                        <TextField
                                            {...params}
                                            error={!newMatricula?.CodCurso}
                                            label="Seleccionar Curso"
                                            variant="outlined"
                                            InputProps={{
                                                ...params.InputProps,
                                                endAdornment: (
                                                    <Fragment>
                                                        {queryCursoInProgress ?
                                                            <CircularProgress
                                                                color="inherit"
                                                                size={20}/> : null}
                                                        {params.InputProps.endAdornment}
                                                    </Fragment>
                                                ),
                                            }}
                                        />}
                                />
                            </FormControl>
                        </Grid>

                        {/*matricula input 2*/}
                        <Grid item xs={12}>
                            <FormControl variant="outlined"
                                         className={classes.formControl}>
                                <Autocomplete
                                    disableClearable
                                    className={`alumno`}
                                    options={alumnos || []}
                                    getOptionLabel={(option) => option.nombre_completo || ""}
                                    onChange={(e: React.ChangeEvent<{}>, selectedOption) =>
                                        setNewMatricula({
                                        ...newMatricula,
                                        Legajo: selectedOption?.id || 0,
                                    })}
                                    style={{width: 300}}
                                    renderInput={(params) =>
                                        <TextField
                                            {...params}
                                            error={!newMatricula?.Legajo}
                                            label="Seleccionar Alumno"
                                            variant="outlined"
                                            InputProps={{
                                                ...params.InputProps,
                                                endAdornment: (
                                                    <Fragment>
                                                        {queryDocenteInProgress ?
                                                            <CircularProgress
                                                                color="inherit"
                                                                size={20}/> : null}
                                                        {params.InputProps.endAdornment}
                                                    </Fragment>
                                                ),
                                            }}
                                        />}
                                />
                            </FormControl>
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
                                !newMatricula.CodCurso ||
                                !newMatricula.Legajo
                            }
                            onClick={saveMatricula}
                        >
                            crear
                        </Button>
                    </Grid>
                </Grid>
            </Container>
        </Grid>
    );
};
