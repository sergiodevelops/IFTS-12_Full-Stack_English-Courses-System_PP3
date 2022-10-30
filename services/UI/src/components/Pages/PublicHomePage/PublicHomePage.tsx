import * as React from 'react';
import Box from '@mui/material/Box';
import Footer from '@components/Footer/Footer';
import { PublicNavBar } from '@components/Pages/PublicHomePage/PublicNavBar/PublicNavBar';
import Typography from '@mui/material/Typography';
import Login from '@components/Pages/Login/Login';
import { useEffect, useState } from 'react';
import {useDispatch, useSelector} from 'react-redux';
import { RootState } from '@redux/reducers/allReducers';
import NewsPosts from '@components/Pages/NewsPosts/NewsPosts';
import { Grid } from '@mui/material';
import PrivateCampus from '@components/PrivateCampus/PrivateCampus';
import useStyles from './styles';
import Building from '@components/Building/Building';
import ContentInicio from '@src/components/ContentInicio/ContentInicio';
import Carousel from '@src/components/Carousel/CarouselInit';
import Nosotros from '@src/components/Nosotros/Nosotros';

// !import datos:
import {
    presInicio,
    nosotrosInfo,
} from '@constants/contentData';
import layoutActions from "@redux/actions/layoutActions";

//!importar datos para  inicio:
const { titulo, descripcion } = presInicio;

export default function PublicHomePage(props: {isAdmin?: boolean}): JSX.Element {
    const dispatch = useDispatch();

    const homePageTabValueStore = useSelector(
        (state: RootState) => state.layoutReducers.homePageTabValueStore || '0',
    );

    // usuario esta logueado o no?
    const userIsLoggedIn: boolean = !!useSelector(
        (state: RootState) => state?.userReducers.currentUser,
    );
    const [sesionActiva, setSesionActiva] = useState<boolean>(userIsLoggedIn);

    const classes = useStyles();
    const [homeTabValue, setHomeTabValue] = React.useState(
        homePageTabValueStore,
    );

    interface TabPanelProps {
        children?: React.ReactNode;
        index: number;
        value: number;
    }

    function TabPanel(props: TabPanelProps) {
        const { children, value, index, ...other } = props;

        return (
            <div
                role="tabpanel"
                hidden={value !== index}
                id={`simple-tabpanel-${index}`}
                aria-labelledby={`simple-tab-${index}`}
                {...other}
            >
                {value === index && (
                    <Box sx={{ p: 3 }}>
                        <Typography>{children}</Typography>
                    </Box>
                )}
            </div>
        );
    }

    useEffect(() => {
        if (props.isAdmin)
            dispatch(layoutActions.setHomeTabValue(4));
    }, [props.isAdmin]);

    useEffect(() => {
        setSesionActiva(userIsLoggedIn);
    }, [userIsLoggedIn]);

    useEffect(() => {
        console.log(
            'llego de redux para mostrar contenido',
            homePageTabValueStore,
        );
        setHomeTabValue(homePageTabValueStore);
    }, [homePageTabValueStore]);

    return (
        <Box className={`${classes.root} DangrekFont`} sx={{ flexGrow: 1 }}>
            {!sesionActiva && <PublicNavBar />}
            <Box id={'inicio'} sx={{ width: '100%' }}>
                {/* inicio */}
                <TabPanel value={Number(homeTabValue)} index={0}>
                    <Carousel />
                    {/* cards: */}
                    <Grid
                        className={`${classes.inicio} ${classes.content}`}
                        item
                        xs={12}
                    >
                        <ContentInicio {...{titulo, descripcion}}/>
                    </Grid>
                </TabPanel>
                {/* nosotros */}
                <TabPanel value={Number(homeTabValue)} index={1}>
                    <Grid
                        className={`${classes.nosotros} ${classes.content}`}
                        item
                        xs={12}
                    >
                        <Nosotros/>
                    </Grid>
                </TabPanel>
                {/* novedades */}
                <TabPanel value={Number(homeTabValue)} index={2}>
                    <NewsPosts {...{ tab: homePageTabValueStore === 2 }} />
                </TabPanel>
                {/* contacto */}
                <TabPanel value={Number(homeTabValue)} index={3}>
                    <Grid item xs={12}>
                        <h1 className={classes.contactTitle}>{"Contacto"}</h1>
                        <Building />
                    </Grid>
                </TabPanel>
                {/* login sección oculta */}
                <TabPanel value={Number(homeTabValue)} index={4}>
                    {!sesionActiva ? <Login /> : <PrivateCampus />}
                </TabPanel>
            </Box>
            <Footer />
        </Box>
    );
}
