import React, {useEffect, useState} from 'react';
import {Grid, Paper} from '@mui/material';
import AvisoService from "@services/AvisoService";
import IPaginationSetDto from "@usecases/pagination/set/IPaginationSetDto";
import IFilterSetDto from "@usecases/filter/add/IFilterSetDto";
import INewCreateResDto from "@usecases/jobad/create/INewCreateResDto";
import {useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import Typography from "@mui/material/Typography";
import moment from "moment";
import useStyles from "./styles";

export default function NewsPosts(props: {getNews: boolean}) {
    const classes = useStyles();

    const [currentQueryCase, setCurrentQueryCase] = useState<number>();

    const avisoService = new AvisoService();
    const [queryInProgress, setQueryInProgress] = useState<boolean>(false);
    const [newsPosts, setNewsPosts] = useState<INewCreateResDto[]>([]);
    const [currentPage, setCurrentPage] = useState<number>(0);
    const [totalPages, setTotalPages] = useState<number>(0);
    const [totalItems, setTotalItems] = useState<number>(0);
    const modalStateStore = useSelector((state: RootState) => state.layoutReducers.openModal);

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

    /*useEffect(() => {
        if (queryNumber !== undefined) {
            setCurrentQueryCase(parseInt(queryNumber));
            console.log("case ", queryNumber);
        }
    }, [queryNumber])*/

    useEffect(() => {
        props.getNews && getNewsByFilters();
    }, [props.getNews])

    return (
        <Grid container justifyItems={"center"}>
            <Grid item xs={12} >
                <Typography align={"center"} variant={"h2"}>Novedades y más</Typography>
            </Grid>
            {newsPosts && newsPosts.map((elem: INewCreateResDto, idx: number) =>
                <Grid item key={`${idx}-${elem.titulo}`} xs={12} justifyContent={"center"}>
                        <Paper className={classes.container}>
                            <Typography
                                textAlign={'center'}
                                variant={'h4'}
                                // className={classes.title}
                            >
                                {elem.titulo}
                            </Typography>
                            <Typography
                                textAlign={'center'}
                                variant={'body1'}
                                // className={classes.desc}
                            >
                                {elem.descripcion}
                            </Typography>
                            <Typography
                                textAlign={'center'}
                                variant={'body1'}
                                // className={classes.date}
                            >
                                {moment(elem.fecha_alta).format("DD-MM-YYYY HH:mm")}
                            </Typography>
                        </Paper>
                </Grid>
            )}
        </Grid>
    );
};
