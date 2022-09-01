import * as React from 'react';
// import {alpha} from '@mui/material/styles';
// import Box from '@mui/material/Box';
// import Table from '@mui/material/Table';
// import TableBody from '@mui/material/TableBody';
// import TableCell from '@mui/material/TableCell';
// import TableContainer from '@mui/material/TableContainer';
// import TableHead from '@mui/material/TableHead';
// import TablePagination from '@mui/material/TablePagination';
// import TableRow from '@mui/material/TableRow';
// import TableSortLabel from '@mui/material/TableSortLabel';
// import Toolbar from '@mui/material/Toolbar';
// import Typography from '@mui/material/Typography';
// import Paper from '@mui/material/Paper';
// import Checkbox from '@mui/material/Checkbox';
// import IconButton from '@mui/material/IconButton';
// import Tooltip from '@mui/material/Tooltip';
// import FormControlLabel from '@mui/material/FormControlLabel';
// import Switch from '@mui/material/Switch';
// import DeleteIcon from '@mui/icons-material/Delete';
// import FilterListIcon from '@mui/icons-material/FilterList';
import {useEffect, useState} from "react";
// import {visuallyHidden} from '@mui/utils';
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
import PostulanteService from "@services/PostulanteService";
import AnuncioService from "@services/AnuncioService";
import IApplicantFindResDto
    from "@usecases/applicant/find/IApplicantFindResDto";
import IJobAdFindResDto
    from "@usecases/jobad/find/IJobAdFindResDto";
import IJobAdCreateResDto
    from "@usecases/jobad/create/IJobAdCreateResDto";
import IApplicantCreateResDto
    from "@usecases/applicant/create/IApplicantCreateResDto";
import UserUpdateDeleteForm
    from "@components/Forms/UserForms/UserUpdateDeleteForm/UserUpdateDeleteForm";
import {queriesEnum} from "@constants/queriesEnum";
import IUserCreateResDto
    from "@usecases/user/create/IUserCreateResDto";
import ApplicantUpdateDeleteForm
    from "@components/Forms/ApplicantForms/ApplicantUpdateDeleteForm/ApplicantUpdateDeleteForm";
import JobAdUpdateDeleteForm
    from "@components/Forms/JobAdForms/JobAdUpdateDeleteForm/JobAdUpdateDeleteForm";
import moment from "moment";

export default function TableData() {
    const dispatch = useDispatch();

    const classes = useStyles();

    const modalStateStore = useSelector((state: RootState) => state.layoutReducers.openModal);
    const queryNumber = useSelector((state: RootState) => state?.layoutReducers.mainTabValueStore);
    const [currentQueryCase, setCurrentQueryCase] = useState<number>();

    const {viewportHeight} = useWindowDimensions();

    const currentMainTabHeight = useSelector((state: RootState) => state.layoutReducers);
    const [minHeightTable, setMinHeightTable] = useState<number>(600);
    // const rowRef = useRef<HTMLDivElement>();

    // const [order, setOrder] = useState<Order>('asc');
    // const [orderBy, setOrderBy] = useState<string/*keyof Data*/>('calories');
    // const [selected, setSelected] = useState<readonly string[]>([]);
    // const [dense, setDense] = useState<boolean>(false);

    // const [headCells, setHeadCells] = useState<HeadCell[] | undefined>();
    const [rows, setRows] = useState<(IUserCreateResDto
        |
        IApplicantCreateResDto
        |
        IJobAdCreateResDto)[]>([]);

    const paginationDefault = {size: 1, page: 0};
    const [pagination, setPagination] = useState<IPaginationSetDto>(paginationDefault);
    const [currentPage, setCurrentPage] = useState<number>(0);
    const [arrowPage, setArrowPage] = useState<number>(0);
    const [intervalPage, setIntervalPage] = useState<number>(1);
    // const [rowsPerPage, setRowsPerPage] = useState<number>(5);
    const [totalPages, setTotalPages] = useState<number>(0);
    const [totalItems, setTotalItems] = useState<number>(0);
    // const [filters, setFilters] = useState<IFilterSetDto[] | undefined>();
    const [bodyComponent, setBodyComponent] = useState<React.ReactHTML>();
    const [clickedRow, setClickedRow] = useState<(IUserLoginResDto
        |
        IApplicantCreateResDto
        |
        IJobAdCreateResDto)>();
    const [currentForm, setCurrentForm] = useState();
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

    const getPostulantesByFilters = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const postulanteService = new PostulanteService();
        setQueryInProgress(true);

        postulanteService
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
            .then((response: IJobAdFindResDto) => {
                // console.log("response", response);
                const {jobads, totalPages, totalItems, currentPage} = response;
                // if (!!jobads.length) {
                    setRows(jobads as IJobAdCreateResDto[]);
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
        setCurrentPage(pagination.page);
    }, [pagination.page])

    useEffect(() => {
        if (queryNumber !== undefined /*&& currentQueryCase != parseInt(queryNumber)*/) {
            setCurrentQueryCase(parseInt(queryNumber));
            console.log("case ", queryNumber);
        }
    }, [queryNumber])

    useEffect(() => {
        if (currentQueryCase !== undefined){
            // if (currentPage !== pagination.page && currentPage >= 0) {
            let newPagination;
            let newFilters;
            // CONSULTAS segun TAB VALUE (Administrativos)
            switch (currentQueryCase) {
                // 0 CONSULTA Users --> filtra por Postulantes (applicants) (value:
                // '3')
                case (queriesEnum.applicantUsersList):
                    console.log("currentQueryCase",currentQueryCase)
                    setBackColor('#ffb8b8');
                    newPagination = {size: 3, page: currentPage};
                    newFilters = [{key: 'tipo_usuario', value: '3'}];
                    getUsersByFilters(newPagination, newFilters);
                    break;
                // 1 CONSULTA Users --> filtra por Solicitantes (clients) (value:
                // '2')
                case (queriesEnum.clientUsersList):
                    console.log("currentQueryCase",currentQueryCase)
                    setBackColor('#d2e3fd');
                    newPagination = {size: 3, page: currentPage};
                    newFilters = [{key: 'tipo_usuario', value: '2'}];
                    getUsersByFilters(newPagination, newFilters);
                    break;
                // 2 CONSULTA Users --> filtra por Administrativos (selectors)
                // (value: '1')
                case (queriesEnum.selectorUsersList):
                    console.log("currentQueryCase",currentQueryCase)
                    setBackColor('#ffd5b5');
                    newPagination = {size: 3, page: currentPage};
                    newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getUsersByFilters(newPagination, newFilters);
                    break;
                // 3 CONSULTA Info de Postulantes (Applicants)
                case (queriesEnum.applicantUsersInfoList):
                    console.log("currentQueryCase",currentQueryCase)
                    // CONSULTA segun TAB VALUE (Postulantes)
                    setBackColor('#acfedc');
                    newPagination = {size: 5, page: currentPage};
                    // newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getPostulantesByFilters(newPagination, newFilters); //Applicants
                    break;
                // 4 CONSULTA Info de Avisos (JobAds)
                case (queriesEnum.jobAdsList):
                    console.log("currentQueryCase",currentQueryCase)
                    // CONSULTA segun TAB VALUE (Anuncios)
                    setBackColor('#fdffb5');
                    newPagination = {size: 5, page: currentPage};
                    // newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getAnunciosByFilters(newPagination, newFilters); //JobAds
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
                    currentQueryCase === queriesEnum.selectorUsersList
                )
                &&
                < UserUpdateDeleteForm row={clickedRow as IUserCreateResDto}/>}

                { // si es consulta de Applicants Info by Filters
                    currentQueryCase === queriesEnum.applicantUsersInfoList
                    &&
                    < ApplicantUpdateDeleteForm
                        row={clickedRow as IApplicantCreateResDto}/>}

                { // si es consulta de JobAds Info by Filters
                    currentQueryCase === queriesEnum.jobAdsList
                    &&
                    < JobAdUpdateDeleteForm
                        row={clickedRow as IJobAdCreateResDto}/>}
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
                    <Grid
                        className={`${classes.arrowChangeQueryPage}`}
                        onClick={() => handleArrowChangePage(-intervalPage)}
                        item xs={1}
                        style={{opacity: currentPage > 0 ? '1' : '0.3'}}
                    >
                        <ArrowLeftIcon
                            fontSize={'large'}
                            style={{color: currentPage > 0 ? '#e8ffe9' : '#2a77d20d'}}
                        />
                    </Grid>

                    <Grid
                        item xs={10}
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
                            className={classes.tableHeaderRow}
                            style={{width: '100%', background: backColor}}
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
                                            className={'tableHeadCell'}
                                        >{cell.toUpperCase()}</Grid>)
                            }
                        </Grid>
                        {
                            rows
                                .map((row: any, index: number) => {
                                    return (
                                        <Grid
                                            className={classes.tableBodyRow}
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
                                                        className={classes.tableBodyCell}
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
                        className={`${classes.arrowChangeQueryPage}`}
                        onClick={() => handleArrowChangePage(+intervalPage)}
                        item xs={1}
                        style={{opacity: currentPage < totalPages - 1 ? '1' : '0.3'}}
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
