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
import IMatriculaCreateReqDto from "@usecases/matricula/create/IMatriculaCreateReqDto";
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
import IMatriculaCreateResDto from "@usecases/matricula/create/IMatriculaCreateResDto";
import MatriculaService from "@services/MatriculaService";
import matriculaStates from "@constants/matriculaStates";

export default function MatriculaUpdateDeleteForm(props: { row: any }) {
    const {IdMatricula} = props.row;
    const title = "Modificar o eliminar";
    const row = props;
    const matriculaService = new MatriculaService();
    const dispatch = useDispatch();
    const classes = useStyles();
    const emptyMatriculaModify: any = {
        estado: "",
    };

    const [updateQueryMatricula, setUpdateQueryMatricula] = useState<any>(emptyMatriculaModify);
    const [updateButtonDisable, setUpdateButtonDisable] = useState(false);

    const [aulas, setAulas] = useState<(IClassroomCreateResDto)[]>([]);
    const [aula, setAula] = useState<IClassroomCreateResDto | undefined>(undefined);
    const [docentes, setDocentes] = useState<(IUserCreateResDto)[]>([]);
    const [docente, setDocente] = useState<IUserCreateResDto | undefined>(undefined);
    // const aula: IClassroomCreateResDto = aulas.; //CodAula
    // const docente: IUserCreateResDto = row; //CodDocente

    const [queryInProgress, setQueryInProgress] = useState<boolean>(false);
    const [queryDocenteInProgress, setQueryDocenteInProgress] = useState<boolean>(false);
    const matriculaState = React.useState(matriculaStates.map(
        (matriculaState: string) => {
            if (matriculaState.toLowerCase() === props.row.estado.toLowerCase())
                return (matriculaState);
            return "";
        }
    ));


    useEffect(() => {
        const newPagination = {size: 10, page: 0};
        getAulas(newPagination);
        getDocentesByFilters(newPagination);

    }, []);

    useEffect(() => {
        setUpdateQueryMatricula({
            IdMatricula: props.row.IdMatricula,
            fecha: props.row.fecha,
            estado: props.row.estado,
            CodCurso: props.row.CodCurso,
            Legajo: props.row.Legajo,
        });
    }, [row])


    const handleClickReplaceRow = async () => {
        const matriculaToReplace: any = {
            IdMatricula: props.row.IdMatricula,
            fecha: props.row.fecha,
            estado: updateQueryMatricula?.estado || props.row.estado,
            CodCurso: props.row.CodCurso,
            Legajo: props.row.Legajo,
        };

        matriculaService
            .replace(matriculaToReplace, IdMatricula)
            .then(() => {
                alert(`La matricula se actualizó exitosamente`);
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
                    <h4 className={classes.titulo}>{`Curso ${updateQueryMatricula?.CodCurso} ${updateQueryMatricula?.comision}`}</h4>
                </Grid>
                <Grid item xs={12}>
                    <FormControl variant="outlined" className={classes.formControl}>
                        <Autocomplete
                            disableClearable
                            className={`matriculaState`}
                            disabled={!updateQueryMatricula}
                            options={matriculaStates || []}
                            getOptionLabel={(option) => `Estado: ${option}`|| ""}
                            value={updateQueryMatricula.estado}
                            onChange={(e: React.ChangeEvent<{}>, selectedOption) =>
                                setUpdateQueryMatricula({
                                ...updateQueryMatricula,
                                estado: selectedOption || 0,
                            })}
                            style={{width: 300}}
                            renderInput={(params) =>
                                <TextField
                                    {...params}
                                    error={!updateQueryMatricula?.CodAula}
                                    style={{background: updateQueryMatricula.IdMatricula !== IdMatricula ? '#e8ffe9' : 'inherit'}}
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
                </Grid>
            </Grid>
        </Container>
    );
};
