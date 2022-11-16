import AppBar from "@mui/material/AppBar";
import Toolbar from "@mui/material/Toolbar";
import Button from "@mui/material/Button";
import * as React from "react";
import {useEffect} from "react";
import layoutActions from "@redux/actions/layoutActions";
import {useDispatch} from "react-redux";
import chesterIcon from "@assets/images/chester-institute-icon.png";
import Box from "@mui/material/Box";
import {Tab, Tabs} from "@mui/material";
import useStyles from "./styles";

export function PublicNavBar() {
    const [homeTabValue, setHomeTabValue] = React.useState(0);
    const dispatch = useDispatch();
    const classes = useStyles();

    const handleChange = (event: React.SyntheticEvent | any, newValue: string) => {
        setHomeTabValue(parseInt(newValue));
    };

    function a11yProps(index: number) {
        return {
            id: `simple-tab-${index}`,
            'aria-controls': `simple-tabpanel-${index}`,
        };
    }


    useEffect(() => {
        dispatch(layoutActions.setHomeTabValue(homeTabValue));
    }, [homeTabValue])


    return <AppBar className={classes.root} position="static">
        <Toolbar className={classes.toolbar} >

            <div onClick={() => setHomeTabValue(0)} className={classes.titleLogoContainer}>
                <img className={classes.logo} alt={"logo chester institute"} src={chesterIcon}/>
                <Button color="inherit" >Chester Institute</Button>
            </div>

            <Box className={classes.tabs} sx={{ borderBottom: 1, borderColor: 'divider', color: "white" }}>
                <Tabs value={homeTabValue} onChange={handleChange} aria-label="basic tabs example">
                    <Tab style={{color: "white"}} tabIndex={0}
                         label="inicio" {...a11yProps(0)} href={"/#"}/>

                    <Tab style={{color: "white"}} tabIndex={1}
                         label="nosotros" {...a11yProps(1)} href={"/#nosotros"}/>

                    <Tab style={{color: "white"}} tabIndex={2}
                         label="novedades" {...a11yProps(2)} href={"/#news"}/>

                    <Tab style={{color: "white"}} tabIndex={3}
                         label="contacto" {...a11yProps(3)} href={"/#contacto"}/>
                </Tabs>
            </Box>

            <Button
                disabled
                style={{visibility: "hidden", fontWeight: homeTabValue === 4 ? "bolder" : "inherit"}}
                onClick={() => setHomeTabValue(4)}
                color="inherit">login</Button>
        </Toolbar>
    </AppBar>;
}