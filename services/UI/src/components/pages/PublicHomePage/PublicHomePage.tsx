import * as React from 'react';
import Box from '@mui/material/Box';
import Footer from "@components/Footer/Footer";
import useStyles from "./styles";
import {
    PublicNavBar
} from "@components/pages/PublicHomePage/PublicNavBar/PublicNavBar";
import Typography from '@mui/material/Typography';
import Login from "@components/pages/Login/Login";
import {useEffect, useState} from "react";
import {useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import NewsPosts from "@components/pages/NewsPosts/NewsPosts";
import {Grid} from "@mui/material";
import PrivateCampus from "@components/DoubleSideBar/PrivateCampus";


export default function ButtonAppBar() {
    const homePageTabValueStore = useSelector((state: RootState) => state.layoutReducers.homePageTabValueStore || "0");

    // usuario esta logueado o no?
    const userIsLoggedIn: boolean = !!useSelector((state: RootState) => state?.userReducers.currentUser);
    const [sesionActiva, setSesionActiva] = useState<boolean>(userIsLoggedIn);

    const classes = useStyles();
    const [homeTabValue, setHomeTabValue] = React.useState(homePageTabValueStore);

    interface TabPanelProps {
        children?: React.ReactNode;
        index: number;
        value: number;
    }

    function TabPanel(props: TabPanelProps) {
        const {children, value, index, ...other} = props;

        return (
            <div
                role="tabpanel"
                hidden={value !== index}
                id={`simple-tabpanel-${index}`}
                aria-labelledby={`simple-tab-${index}`}
                {...other}
            >
                {value === index && (
                    <Box sx={{p: 3}}>
                        <Typography>{children}</Typography>
                    </Box>
                )}
            </div>
        );
    }



    useEffect(() => {
        setSesionActiva(userIsLoggedIn)
    }, [userIsLoggedIn]);

    useEffect(() => {
        console.log("llego de redux para mostrar contenido", homePageTabValueStore)
        setHomeTabValue(homePageTabValueStore);
    }, [homePageTabValueStore]);

    return (
        <Box className={classes.root} sx={{flexGrow: 1}}>
            {!sesionActiva && <PublicNavBar/>}
            <Box className={classes.content} sx={{width: '100%'}}>
                <TabPanel value={Number(homeTabValue)} index={0}>
                    <Grid item xs={12} >
                        <Typography align={"center"} variant={"h2"}>INICIO</Typography>
                    </Grid>
                </TabPanel>
                <TabPanel value={Number(homeTabValue)} index={1}>
                    <Grid item xs={12} >
                        <Typography align={"center"} variant={"h2"}>NOSOTROS</Typography>
                    </Grid>
                </TabPanel>
                <TabPanel value={Number(homeTabValue)} index={2}>
                    <NewsPosts {...{getNews: homePageTabValueStore === 2}}/>
                </TabPanel>
                <TabPanel value={Number(homeTabValue)} index={3}>
                    <Grid item xs={12} >
                        <Typography align={"center"} variant={"h2"}>CONTACTO</Typography>
                    </Grid>
                </TabPanel>
                <TabPanel value={Number(homeTabValue)} index={4}>
                    {!sesionActiva ? <Login/> : <PrivateCampus/>}
                </TabPanel>
            </Box>
            <Footer/>
        </Box>
    );
}
