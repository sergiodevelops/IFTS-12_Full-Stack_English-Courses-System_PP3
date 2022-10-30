import React, {useEffect, useState, Fragment} from 'react';
import {useDispatch} from "react-redux";
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import CursoService from "@services/CursoService";
import AulaService from "@services/AulaService";
import UsuarioService from "@services/UsuarioService";
import useStyles from "./styles";
import layoutActions from "@redux/actions/layoutActions";
import ICourseCreateResDto
    from "@usecases/course/create/ICourseCreateResDto";
import ICourseCreateReqDto
    from "@usecases/course/create/ICourseCreateReqDto";
import FormControl from "@material-ui/core/FormControl";
import Autocomplete from "@material-ui/lab/Autocomplete";
import CircularProgress from '@mui/material/CircularProgress';
import IPaginationSetDto
    from "@usecases/pagination/set/IPaginationSetDto";
import IFilterSetDto from "@usecases/filter/add/IFilterSetDto";
import IClassroomFindResDto
    from "@usecases/classroom/find/IClassroomFindResDto";
import IClassroomCreateResDto
    from "@usecases/classroom/create/IClassroomCreateResDto";
import IUserCreateResDto from "@usecases/user/create/IUserCreateResDto";
import IUserFindResDto from "@usecases/user/find/IUserFindResDto";
import userTypes from "@constants/userTypes";

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
    const classes = useStyles();
    const emptyCourseModify: ICourseCreateReqDto = {
        comision: "",
        CodAula: 0,
        CodDocente: 0,
        CodNivel: 0,
    };

    const [updateQueryCourse, setUpdateQueryCourse] = useState<ICourseCreateReqDto>(emptyCourseModify);
    const [updateButtonDisable, setUpdateButtonDisable] = useState(false);

    const [aulas, setAulas] = useState<(IClassroomCreateResDto)[]>([]);
    const [aula, setAula] = useState<IClassroomCreateResDto | undefined>(undefined);
    const [docentes, setDocentes] = useState<(IUserCreateResDto)[]>([]);
    const [docente, setDocente] = useState<IUserCreateResDto | undefined>(undefined);
    // const aula: IClassroomCreateResDto = aulas.; //CodAula
    // const docente: IUserCreateResDto = row; //CodDocente

    const [queryInProgress, setQueryInProgress] = useState<boolean>(false);
    const [queryDocenteInProgress, setQueryDocenteInProgress] = useState<boolean>(false);


    useEffect(() => {
        const newPagination = {size: 10, page: 0};
        getAulas(newPagination);
        getDocentesByFilters(newPagination);

    }, []);

    useEffect(() => {
        setUpdateQueryCourse({
            comision,
            CodAula,
            CodDocente,
            CodNivel,
            CodCurso,
        });
    }, [row])


    const handleClickReplaceRow = async () => {
        const courseToReplace: ICourseCreateReqDto = {
            comision: updateQueryCourse?.comision, // mapeo para la base, envia un number
            CodAula: !!updateQueryCourse?.CodAula ? updateQueryCourse?.CodAula :  CodAula,
            CodDocente: !!updateQueryCourse?.CodDocente ? updateQueryCourse?.CodDocente :  CodDocente,
            CodNivel: updateQueryCourse?.CodNivel,
        };

        cursoService
            .replace(courseToReplace, CodCurso)
            .then(() => {
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
    }

    const handleClickDeleteRow = async () => {
        cursoService
            .delete(CodCurso)
            .then(() => {
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
    }

    const getAulas = async(
        pagination: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const aulaService = new AulaService();
        setQueryInProgress(true);

        let response: IClassroomFindResDto ;
        response = await aulaService.findAllByFilters(pagination, filters);
        if(!response) throw Error("No llego info en primer lista");

        let aulas = response.classrooms;
        const {totalPages, currentPage} = response;
        if(totalPages > 1){
            for(let i = currentPage; i < totalPages - 1; i++){
                pagination = {...pagination, page: i + 1};
                response = await aulaService.findAllByFilters(pagination, filters);
                if(!response) throw Error("No llego info en el for");
                aulas = [...aulas, ...response.classrooms];
            }
        }
        setAulas(aulas);
        setQueryInProgress(false);
    }


    const getDocentesByFilters = async(
        pagination: IPaginationSetDto,
    ) => {
        setQueryDocenteInProgress(true);

        const userService = new UsuarioService();

        let response: IUserFindResDto ;
        const docentesFilter = [{key: 'tipo_usuario', value: '2'}];

        response = await userService.findAllByFilters(pagination, docentesFilter);
        if(!response) throw Error("No llego info en primer lista");

        let docentes = response.users;
        const {totalPages, currentPage} = response;
        if(totalPages > 1){
            for(let i = currentPage; i < totalPages - 1; i++){
                pagination = {...pagination, page: i + 1};
                response = await userService.findAllByFilters(pagination, docentesFilter);
                if(!response) throw Error("No llego info en el for");
                docentes = [...docentes, ...response.users];
            }
        }
        setDocentes(docentes);
        setQueryDocenteInProgress(false);
    }


    return (
        <Container className={classes.container} maxWidth="xs">
            <Grid>
                <Grid item xs={12}>
                    <h3 className={classes.titulo}>{title}</h3>
                    <h4 className={classes.titulo}>{`Curso ${updateQueryCourse?.CodCurso} ${updateQueryCourse?.comision}`}</h4>
                </Grid>
                <Grid item xs={12}>
                    <FormControl variant="outlined" className={classes.formControl}>
                        <Autocomplete
                            disableClearable
                            className={`CodAula`}
                            disabled={!updateQueryCourse}
                            options={aulas || []}
                            getOptionLabel={(option) => `Aula: ${option.CodAula} | Capacidad: ${option.capacidad}`|| ""}
                            defaultValue={aula ? aula : aulas[0]}
                            onChange={(e: React.ChangeEvent<{}>, selectedOption) => setUpdateQueryCourse({
                                ...updateQueryCourse,
                                CodAula: selectedOption?.CodAula || 0,
                            })}
                            style={{width: 300}}
                            renderInput={(params) =>
                                <TextField
                                    {...params}
                                    error={!updateQueryCourse?.CodAula}
                                    style={{background: updateQueryCourse.CodAula !== CodAula ? '#e8ffe9' : 'inherit'}}
                                    label="Seleccionar Aula"
                                    variant="outlined"
                                    InputProps={{
                                        ...params.InputProps,
                                        endAdornment: (
                                            <Fragment>
                                                {queryInProgress ?
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
                <Grid item xs={12}>
                    <FormControl variant="outlined"
                                 className={classes.formControl}>
                        <Autocomplete
                            disableClearable
                            className={`docente`}
                            disabled={!updateQueryCourse}
                            options={docentes || []}
                            getOptionLabel={(option) => option.nombre_completo || ""}
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
                                    label="Seleccionar Docente"
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
