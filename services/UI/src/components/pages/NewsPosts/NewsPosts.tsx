import React, {useEffect, useState} from 'react';
import {Grid, Paper} from '@mui/material';
import {styled} from '@mui/material/styles';
import AvisoService from "@services/AvisoService";
import IPaginationSetDto from "@usecases/pagination/set/IPaginationSetDto";
import IFilterSetDto from "@usecases/filter/add/IFilterSetDto";
import INewCreateResDto from "@usecases/jobad/create/INewCreateResDto";
import {queriesEnum} from "@constants/queriesEnum";
import {useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import useStyles from "./styles";
import Typography from "@mui/material/Typography";
import moment from "moment";

export default function NewsPosts() {
    const classes = useStyles();

    const [currentQueryCase, setCurrentQueryCase] = useState<number>();
    const avisoService = new AvisoService();
    const [queryInProgress, setQueryInProgress] = useState<boolean>(false);
    const [newsPosts, setNewsPosts] = useState<INewCreateResDto[]>([]);
    const [currentPage, setCurrentPage] = useState<number>(0);
    const [totalPages, setTotalPages] = useState<number>(0);
    const [totalItems, setTotalItems] = useState<number>(0);
    const modalStateStore = useSelector((state: RootState) => state.layoutReducers.openModal);
    const queryNumber = useSelector((state: RootState) => state?.layoutReducers.mainTabValueStore);

    const getNewsByFilters = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const usuarioService = new AvisoService();
        setQueryInProgress(true);

        usuarioService
            .findAllByFilters(pagination, filters)
            .then((response: any) => {
                // console.log("response", response);
                const {news, totalPages, totalItems, currentPage} = response;
                // if (!!users.length) {
                setNewsPosts(news.reverse());
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
                // 4 CONSULTA Info de Avisos (NewsPosts)
                case (queriesEnum.newsPostsList):
                    console.log("currentQueryCase",currentQueryCase)
                    // CONSULTA segun TAB VALUE (Anuncios)
                    newPagination = {size: 20, page: currentPage};
                    // newFilters = [{key: 'tipo_usuario', value: '1'}];
                    getNewsByFilters(newPagination, newFilters); //news
                    break;
                default:
                    console.log("other currentQueryCase",currentQueryCase)
                    // default
                    setNewsPosts([]);
                    break;
            }
        }
    }, [currentPage, currentQueryCase, modalStateStore]);

    return (
        <Grid container spacing={2}>
            {newsPosts && newsPosts.map((elem: INewCreateResDto, idx: number) =>
                <Grid key={`${idx}-${elem.titulo}`} item xs={6}>
                        <Paper className={classes.container}>
                            <Typography
                                textAlign={'center'}
                                variant={'h4'}
                                className={classes.title}
                            >
                                {elem.titulo}
                            </Typography>
                            <Typography
                                textAlign={'center'}
                                variant={'body1'}
                                className={classes.desc}
                            >
                                {elem.descripcion}
                            </Typography>
                            <Typography
                                textAlign={'center'}
                                variant={'body1'}
                                className={classes.date}
                            >
                                {moment(elem.fecha_alta).format("DD-MM-YYYY HH:mm")}
                            </Typography>
                        </Paper>
                </Grid>
            )}
        </Grid>
    );
};
