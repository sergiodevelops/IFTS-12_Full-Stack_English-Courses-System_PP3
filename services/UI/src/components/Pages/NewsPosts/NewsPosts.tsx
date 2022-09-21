import React, {useEffect, useState} from 'react';
import {Grid, Paper} from '@mui/material';
import AvisoService from "@services/AvisoService";
import IPaginationSetDto from "@usecases/pagination/set/IPaginationSetDto";
import IFilterSetDto from "@usecases/filter/add/IFilterSetDto";
import INewCreateResDto from "@usecases/jobad/create/INewCreateResDto";
import Typography from "@mui/material/Typography";
import moment from "moment";
import useStyles from "./styles";

export default function NewsPosts(props: {tab: boolean}) {
    const classes = useStyles();
    const [newsPosts, setNewsPosts] = useState<INewCreateResDto[]>([]);

    const getNewsByFilters = (
        pagination?: IPaginationSetDto,
        filters?: IFilterSetDto[],
    ) => {
        const usuarioService = new AvisoService();

        usuarioService
            .findAllByFilters(pagination, filters)
            .then((response: any) => {
                const {news} = response;
                setNewsPosts(news.reverse());
            })
            .catch((err: any) => {
                console.error("ERROR en FE", err.message);
            });
    }

    useEffect(() => {
        props.tab && getNewsByFilters();
    }, [props.tab])

    return <Grid container justifyItems={"center"}>
            <Grid item xs={12} >
                <Typography className={`${classes.uppercase}`} fontFamily={"DangrekFont"} align={"center"} variant={"h2"}>
                    Novedades y más
                </Typography>
                {!newsPosts.length  &&
                    <Typography
                        className={`${classes.msgQueryResults}`}
                        variant={"h5"}
                        component={"div"}
                        textAlign={'center'}
                        justifyContent={'center'}
                        alignItems={'center'}
                    >
                        No existe aun registros en la base para esta solicitud
                    </Typography>}
            </Grid>
            {newsPosts && newsPosts.map((elem: INewCreateResDto, idx: number) =>
                <Grid item key={`${idx}-${elem.titulo}`} xs={12} justifyContent={"center"}>
                        <Paper elevation={5} className={classes.container}>
                            <Typography
                                textAlign={'center'}
                                variant={'h4'}
                                // className={classes.title}
                            >
                                {elem.titulo.toUpperCase()}
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
};