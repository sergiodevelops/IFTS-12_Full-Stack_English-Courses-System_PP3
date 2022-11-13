import * as React from 'react';
import {useEffect, useState} from "react";
import UsuarioService from "@services/UsuarioService";
import IPaginationSetDto
    from "@usecases/pagination/set/IPaginationSetDto";
import IFilterSetDto from "@usecases/filter/add/IFilterSetDto";
import IUserFindResDto from "@usecases/user/find/IUserFindResDto";
import IUserLoginResDto
    from "@usecases/user/login/IUserLoginResDto";
import Grid from "@material-ui/core/Grid";
import ArrowRightIcon from '@mui/icons-material/ArrowRight';
import ArrowLeftIcon from '@mui/icons-material/ArrowLeft';
import useStyles from "@components/TableData/styles";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import useWindowDimensions from "@components/Hooks/useWindowDimensions";
import BasicModal from "@components/BasicModal/BasicModal";
import layoutActions from "@redux/actions/layoutActions";
import Typography from "@mui/material/Typography";
import Spinner from "@components/ModalSpinner/Spinner/Spinner";
import AlumnoService from "@services/AlumnoService";
import AnuncioService from "@services/AnuncioService";
import CursoService from "@services/CursoService";
import MatriculaService from "@services/MatriculaService";
import IApplicantFindResDto
    from "@usecases/applicant/find/IApplicantFindResDto";
import INewsFindResDto
    from "@usecases/new/find/INewsFindResDto";
import ICoursesFindResDto
    from "@usecases/course/find/ICoursesFindResDto";
import INewCreateResDto
    from "@usecases/new/create/INewCreateResDto";
import IApplicantCreateResDto
    from "@usecases/applicant/create/IApplicantCreateResDto";
import UserUpdateDeleteForm
    from "@components/Forms/UserForms/UserUpdateDeleteForm/UserUpdateDeleteForm";
import {queriesEnum} from "@constants/queriesEnum";
import IUserCreateResDto
    from "@usecases/user/create/IUserCreateResDto";
import NewUpdateDeleteForm
    from "@components/Forms/NewForms/NewUpdateDeleteForm/NewUpdateDeleteForm";
import moment from "moment";
import ICourseCreateResDto from "@usecases/course/create/ICourseCreateResDto";
import CourseUpdateDeleteForm
    from "@components/Forms/CourseForms/CourseUpdateDeleteForm/CourseUpdateDeleteForm";
import IMatriculaFindResDto
    from "@usecases/matricula/find/IMatriculaFindResDto";
import IMatriculaCreateResDto
    from "@usecases/matricula/create/IMatriculaCreateResDto";
import MatriculaUpdateDeleteForm
    from "@components/Forms/MatriculaForms/MatriculaUpdateDeleteForm/MatriculaUpdateDeleteForm";



export default function TableData() {
    const dispatch = useDispatch();

    const classes = useStyles();

    const modalStateStore = useSelector((state: RootState) => state.layoutReducers.openModal);
    const queryNumber = useSelector((state: RootState) => state?.layoutReducers.mainTabValueStore);
    const [currentQueryCase, setCurrentQueryCase] = useState<number>();

    const {viewportHeight} = useWindowDimensions();

    const currentMainTabHeight = useSelector((state: RootState) => state.layoutReducers);
    const [minHeightTable, setMinHeightTable] = useState<number>(600);
    const [rows, setRows] = useState<(
        IUserCreateResDto
        |
        IApplicantCreateResDto
        |
        ICourseCreateResDto
        |
        INewCreateResDto
        |
        IMatriculaCreateResDto
        )[]>([]);

    const paginationDefault = {size: 10, page: 0};
    const [pagination, setPagination] = useState<IPaginationSetDto>(paginationDefault);
    const [currentPage, setCurrentPage] = useState<number>(0);
    const [arrowPage, setArrowPage] = useState<number>(0);
    const [intervalPage, setIntervalPage] = useState<number>(1);
    const [totalPages, setTotalPages] = useState<number>(0);
    const [totalItems, setTotalItems] = useState<number>(0);
    // const [filters, setFilters] = useState<IFilterSetDto[] | undefined>();
    const [clickedRow, setClickedRow] = useState<(IUserLoginResDto
        |
        IApplicantCreateResDto
        |
        ICourseCreateResDto
        |
        INewCreateResDto)>();
    const [queryInProgress, setQueryInProgress] = useState<boolean>(false);
    const [backColor, setBackColor] = useState<string>('#2a77d263');

    const getUsersByFilters = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const usuarioService = new UsuarioService();
        setQueryInProgress(true);

        usuarioService
            .findAllByFilters(pagination, filters)
            .then((response: IUserFindResDto) => {
                // console.log("response", response);
                const {users, totalPages, totalItems, currentPage} = response;
                // if (!!users.length) {
                    setRows(users as IUserCreateResDto[]);
                    setTotalPages(totalPages);
                    setTotalItems(totalItems);
                    setCurrentPage(currentPage);
                // }
                setQueryInProgress(false);
            })
            .catch((err: any) => {
                // err.then((err: any) => {
                console.error("ERROR en FE", err.message);
                // });
                setQueryInProgress(false);
            });
    }

    const getAlumnosByFilters = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const alumnoService = new AlumnoService();
        setQueryInProgress(true);

        alumnoService
            .findAllByFilters(pagination, filters)
            .then((response: IApplicantFindResDto) => {
                // console.log("response", response);
                const {
                    applicants,
                    totalPages,
                    totalItems,
                    currentPage
                } = response;
                // if (!!applicants.length) {
                    setRows(applicants as IApplicantCreateResDto[]);
                    setTotalPages(totalPages);
                    setTotalItems(totalItems);
                    setCurrentPage(currentPage);
                // }
                setQueryInProgress(false);
            })
            .catch((err: any) => {
                // err.then((err: any) => {
                console.error("ERROR en FE", err.message);
                // });
                setQueryInProgress(false);
            });
    }

    const getAnunciosByFilters = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const anuncioService = new AnuncioService();
        setQueryInProgress(true);

        anuncioService
            .findAllByFilters(pagination, filters)
            .then((response: INewsFindResDto) => {
                // console.log("response", response);
                const {
                    news,
                    totalPages,
                    totalItems
                } = response;
                // if (!!news.length) {
                    setRows(news as INewCreateResDto[]);
                    setTotalPages(totalPages);
                    setTotalItems(totalItems);
                    setCurrentPage(currentPage);
                // }
                setQueryInProgress(false);
            })
            .catch((err: any) => {
                // err.then((err: any) => {
                console.error("ERROR en FE", err.message);
                // });
                setQueryInProgress(false);
            });
    }

    const getCursosByFilters = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const cursoService = new CursoService();
        setQueryInProgress(true);

        cursoService
            .findAllByFilters(pagination, filters)
            .then((response: ICoursesFindResDto) => {
                // console.log("response", response);
                const {
                    courses,
                    totalPages,
                    totalItems
                } = response;
                // if (!!news.length) {
                    setRows(courses as ICourseCreateResDto[]);
                    setTotalPages(totalPages);
                    setTotalItems(totalItems);
                    setCurrentPage(currentPage);
                // }
                setQueryInProgress(false);
            })
            .catch((err: any) => {
                // err.then((err: any) => {
                console.error("ERROR en FE", err.message);
                // });
                setQueryInProgress(false);
            });
    }

    const getMatriculas = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const matriculaService = new MatriculaService();
        setQueryInProgress(true);

        matriculaService
            .findAllByFilters(pagination, filters)
            .then((response: IMatriculaFindResDto) => {
                // console.log("response", response);
                const {
                    matriculas,
                    totalPages,
                    totalItems
                } = response;
                // if (!!news.length) {
                    setRows(matriculas as IMatriculaCreateResDto[]);
                    setTotalPages(totalPages);
                    setTotalItems(totalItems);
                    setCurrentPage(currentPage);
                // }
                setQueryInProgress(false);
            })
            .catch((err: any) => {
                // err.then((err: any) => {
                console.error("ERROR en FE", err.message);
                // });
                setQueryInProgress(false);
            });
    }

    const handleTableBodyRowClick = (row: any) => {
        setClickedRow(row);
        // setCurrentForm(<UserUpdateDeleteForm row={clickedRow}/>);
        dispatch(layoutActions.setOpenModal(true));
    }
    const handleArrowChangePage = (intervalPage: number) => { // -5 , + 5 , +1 , -1
        const sumatoria = currentPage + intervalPage;
        const validateNewPage = (): boolean => {
            return (sumatoria >= 0 && sumatoria <= totalPages - 1)
        };
        const calcNewPage = (): number => {
            if (!validateNewPage()) { // si se fue del rango poner al inicio o al final
                return (sumatoria < 0 ? 0 : totalPages);
            }
            return (sumatoria);
        };
        validateNewPage() && setCurrentPage(calcNewPage());
        // console.log(
        //     "currentPageHook", currentPage,
        //     "intervalPage", intervalPage,
        //     "totalPages", totalPages,
        //     "validateNewPage?", validateNewPage(),
        //     "calcNewPage", calcNewPage()
        // );
    };

    useEffect(() => {
        setMinHeightTable(currentMainTabHeight.footerDimensions.height - 64);
    }, [currentMainTabHeight])

    useEffect(() => {
        handleArrowChangePage(arrowPage); // si alguna flecha seteo el arrowPage
    }, [arrowPage])

    useEffect(() => {
        console.log("totalPages", totalPages);
    }, [totalPages])

    useEffect(() => {
        setCurrentPage(pagination.page);
    }, [pagination.page])

    useEffect(() => {
        if (queryNumber !== undefined /*&& currentQueryCase != parseInt(queryNumber)*/) {
            setCurrentQueryCase(parseInt(queryNumber));
            console.log("case ", queryNumber);
        }
    }, [queryNumber])

    useEffect(() => {
        console.log("currentQueryCase",currentQueryCase)

        if (currentQueryCase !== undefined){
            // if (currentPage !== pagination.page && currentPage >= 0) {
            let newPagination;
            let newFilters;
            // GESTION (consulta, modificación, baja) (Administrativos)
            switch (currentQueryCase) {

                // 3 GESTION (consulta, modificación, baja) (alumnos-applic) (value:
                case (queriesEnum.applicantUsersList):
                    console.log("currentQueryCase",currentQueryCase)
                    setBackColor('#ffb8b8');
                    newPagination = {size: 10, page: currentPage};
                    newFilters = [{key: 'tipo_usuario', value: '3'}];
                    getUsersByFilters(newPagination, newFilters);
                    break;

                // 2 GESTION (consulta, modificación, baja) (docentes-clien)
                case (queriesEnum.clientUsersList):
                    console.log("currentQueryCase",currentQueryCase)
                    setBackColor('#d2e3fd');
                    newPagination = {size: 10, page: currentPage};
                    newFilters = [{key: 'tipo_usuario', value: '2'}];
                    getUsersByFilters(newPagination, newFilters);
                    break;

                // 1 GESTION (consulta, modificación, baja) (administrativos)
                case (queriesEnum.administrativoUsersList):
                    console.log("currentQueryCase",currentQueryCase)
                    setBackColor('#ffd5b5');
                    newPagination = {size: 10, page: currentPage};
                    newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getUsersByFilters(newPagination, newFilters);
                    break;

                // GESTION (consulta, modificación, baja)(novedades-news)
                case (queriesEnum.newsPostsList):
                    // CONSULTA segun TAB VALUE (novedades-news)
                    setBackColor('#fdffb5');
                    newPagination = {size: 10, page: currentPage};
                    // newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getAnunciosByFilters(newPagination, newFilters); //novedades-news
                    break;

                // GESTION (consulta, modificación, baja)(cursos)
                case (queriesEnum.coursesList):
                    // CONSULTA segun TAB VALUE (cursos)
                    setBackColor('#fdffb5');
                    newPagination = {size: 10, page: currentPage};
                    // newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getCursosByFilters(newPagination, newFilters); //cursos
                    break;

                // GESTION (consulta, modificación, baja)(matriculas)
                case (queriesEnum.matriculasList):
                    // CONSULTA segun TAB VALUE (cursos)
                    setBackColor('#fdffb5');
                    newPagination = {size: 10, page: currentPage};
                    // newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getMatriculas(newPagination, newFilters); //matriculas
                    break;

                default:
                    console.log("other currentQueryCase",currentQueryCase)
                    // default
                    setRows([]);
                    break;
            }
        }
    }, [currentPage, currentQueryCase, modalStateStore]);

    const renderBodyComponent = () => {
        return (
            <>
                {( // si es consulta de Users by Filters
                    currentQueryCase === queriesEnum.applicantUsersList
                    ||
                    currentQueryCase === queriesEnum.clientUsersList
                    ||
                    currentQueryCase === queriesEnum.administrativoUsersList
                )
                &&
                <UserUpdateDeleteForm row={clickedRow as IUserCreateResDto}/>}


                { // si es consulta de JobAds Info by Filters
                    currentQueryCase === queriesEnum.newsPostsList
                    &&
                    <NewUpdateDeleteForm
                        row={clickedRow as INewCreateResDto}/>}

                { // si es consulta de CourseUpdateDelete Info by Filters
                    currentQueryCase === queriesEnum.coursesList
                    &&
                    <CourseUpdateDeleteForm row={clickedRow as ICourseCreateResDto}/>}

                { // si es consulta de MatriculaUpdateDelete Info
                    currentQueryCase === queriesEnum.matriculasList
                    &&
                    <MatriculaUpdateDeleteForm row={clickedRow as any}/>}
            </>
        )
    }

    return (
        !!rows.length
            ? // si hay contenido para mostrar en la tabla
            (
                <Grid
                    container
                    className={`${classes.root}`}
                >
                    {/*ARROW LEFT PAGINATION*/}
                    <Grid
                        item xs={1}
                        className={`${classes.arrowChangeQueryPage}`}
                        onClick={() => handleArrowChangePage(-intervalPage)}
                        style={{
                            display: totalPages === 1 ? "none":"inherit",
                            opacity: currentPage > 0 ? '1' : '0.3'
                    }}
                    >
                        <ArrowLeftIcon
                            fontSize={'large'}
                            style={{color: currentPage > 0 ? '#e8ffe9' : '#2a77d20d'}}
                        />
                    </Grid>

                    <Grid
                        item xs={totalPages === 1 ? 12 : 10}
                        style={{
                            minHeight: viewportHeight && minHeightTable ?
                                `${viewportHeight - minHeightTable - 64 * 2}px` :
                                '100vh'
                        }}
                        className={classes.queryTable}
                    >
                        <Grid
                            key={`tableHeaderRow`}
                            container
                            className={classes.headerTableRow}
                            // style={{width: '100%', background: backColor}}
                        >
                            {
                                Object
                                    .keys(rows[0])
                                    .map((cell: string, index: number) =>
                                        <Grid
                                            key={`tableHeadCell-${index}`}
                                            item
                                            style={{
                                                width: `${100 / Object.keys(rows[0]).length}%`,
                                            }}
                                            className={`${classes.tableCell}`}
                                        >{cell.toUpperCase()}</Grid>)
                            }
                        </Grid>
                        {
                            rows
                                .map((row: any, index: number) => {
                                    return (
                                        <Grid
                                            className={classes.valuesTableRow}
                                            key={`tableBodyRow-${index}`}
                                            onClick={() => {
                                                handleTableBodyRowClick(row)
                                            }}
                                            container
                                            // style={{background: index % 2 ==
                                            // 0 ? '#00ddff' :
                                            // 'rgba(0,119,255,0.49)'}}
                                        >
                                            {Object
                                                .entries(row)
                                                .map((
                                                    cell: any,
                                                    index: number,
                                                ) =>
                                                    <Grid
                                                        className={classes.tableCell}
                                                        key={`tableBodyCell-${index}`}
                                                        style={{width: `${100 / Object.keys(row).length}%`}}
                                                        item
                                                    >{cell[0] === 'fecha_alta'
                                                        ?
                                                        moment(cell[1]).format("DD-MM-YYYY HH:mm")
                                                        :
                                                        cell[1]}</Grid>)}
                                        </Grid>
                                )
                                })
                        }
                    </Grid>
                    <Grid
                        item xs={1} hidden={totalPages === 1}
                        className={`${classes.arrowChangeQueryPage}`}
                        onClick={() => handleArrowChangePage(+intervalPage)}
                        style={{
                            display: totalPages === 1 ? "none":"inherit",
                            opacity: currentPage < totalPages - 1 ? '1' : '0.3'
                    }}
                    >
                        <ArrowRightIcon
                            fontSize={'large'}
                            style={{color: currentPage < totalPages - 1 ? '#b3b3b3' : '#2a77d20d'}}
                        />
                    </Grid>
                    {clickedRow &&
                    <BasicModal bodyComponent={renderBodyComponent()}/>}
                </Grid>
            ) :
            (
                queryInProgress ?
                    <Spinner style={{
                        minHeight: viewportHeight && minHeightTable ?
                            `${viewportHeight - minHeightTable - 64 * 2}px` :
                            '100vh'
                    }}/>
                    : <Grid
                        container
                        className={`${classes.containerMsgQueryResults}`}
                    >
                        <Typography
                            className={`${classes.msgQueryResults}`}
                            variant={"h5"}
                            component={"div"}
                            textAlign={'center'}
                            justifyContent={'center'}
                            alignItems={'center'}
                        >
                            No existe aun registros en la base para esta solicitud
                        </Typography>
                    </Grid>
            )
    );
}
