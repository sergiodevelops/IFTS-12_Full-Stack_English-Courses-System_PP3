import React, {useEffect, useState} from 'react';
import Box from '@mui/material/Box';
// import Tab from '@mui/material/Tab';
import TabContext from '@mui/lab/TabContext';
// import TabList from '@mui/lab/TabList';
import TabPanel from '@mui/lab/TabPanel';
import {useDispatch, useSelector} from "react-redux";
import layoutActions from "@redux/actions/layoutActions";
import List from '@mui/material/List';
import {ListItem, ListItemText, Tabs/*, Tab*/} from "@material-ui/core";
// import {TabList} from "@material-ui/lab";
// import layoutReducers from "@redux/reducers/layoutReducers";
import {RootState} from "@redux/reducers/allReducers";
import SwipeableViews from 'react-swipeable-views';
import useStyles from './styles'
import Typography from "@mui/material/Typography";

export default function SubMenuTabs() {
    const classes = useStyles();
    const dispatch = useDispatch();
    const subMenuTabValueStore = useSelector((state:RootState) => state.layoutReducers.subMenuTabValueStore);
    // const currentUser = useSelector((state) => state?.userReducers.currentUser);
    const [subMenuTab, setSubMenuTab] = useState("0");
    const [mainTabValue, setMainTabValue] = React.useState("0");


    useEffect(() => {
        setSubMenuTab(subMenuTabValueStore);
    }, [subMenuTabValueStore]);

    useEffect(() => {
        dispatch(layoutActions.setMainTabValue(mainTabValue))
    }, [mainTabValue]);

    const handleClickMenu = (index: number) => {
        setMainTabValue((index).toString());
        // dispatch(layoutActions.setMainTabValue(index === 0 ? '0' : '5'));
    };
    const colorCurrentButtonMenu = '#d6001c';

    return (
        <Box
            sx={{
                width: '100%',
                typography: 'body1'
            }}
        >
            <TabContext value={subMenuTab}>
                {/*SubMenues de CONSULTAS [0 a 3]*/}
                <SwipeableViews index={parseInt(subMenuTab)} className={classes.subMenuItems}>

                    {/*SubMenues de GESTIÓN (edición y borrado) [0 a 5]*/}
                    <TabPanel tabIndex={parseInt(subMenuTab)} value="0">
                        <Typography align={"center"}>GESTIÓN</Typography>
                        <List>
                            {[
                                'Alumnos',
                                'Docentes',
                                'Administrativos',
                                'Anuncios',
                                'Cursos',
                            ].map((text, index) => (
                                <ListItem
                                    button
                                    key={`${text}-${index}`}
                                    style={{
                                        background: mainTabValue && index === parseInt(mainTabValue) ? colorCurrentButtonMenu : 'inherit',
                                    }}
                                    onClick={() => handleClickMenu(index)}
                                >
                                    <ListItemText primary={text}/>
                                </ListItem>
                            ))}
                        </List>
                    </TabPanel>

                    {/*SubMenues de ALTAS [6 a 8]*/}
                    <TabPanel tabIndex={parseInt(subMenuTab)} value="1">
                        <Typography align={"center"}>ALTAS</Typography>
                        <List>
                            {[
                                'Usuarios',
                                'Anuncios',
                                'Cursos',
                            ].map((text: string, index: number) => (
                                <ListItem
                                    button
                                    key={`${text}-${index}`}
                                    style={{
                                        background: mainTabValue && index+5 === parseInt(mainTabValue) ?
                                            colorCurrentButtonMenu : 'inherit',
                                    }}
                                    onClick={() => handleClickMenu(index+5)}
                                >
                                    <ListItemText primary={text}/>
                                </ListItem>
                            ))}
                        </List>
                    </TabPanel>

                    {/*SubMenues de ABM [9 a 12]*/}
                    <TabPanel tabIndex={parseInt(subMenuTab)} value="2">
                        <Typography align={"center"}>GESTIÓN</Typography>
                        <List>
                            {[
                                'MISIÓN',
                                'VISIÓN',
                                'OBJETIVO',
                                'NOSOTROS',
                            ].map((text: string, index: number) => (
                                <ListItem
                                    button
                                    key={`${text}-${index}`}
                                    style={{
                                        background: mainTabValue &&  index+9 === parseInt(mainTabValue) ? colorCurrentButtonMenu : 'inherit',
                                    }}
                                    onClick={() => handleClickMenu(index+9)}
                                >
                                    <ListItemText primary={text}/>
                                </ListItem>
                            ))}
                        </List>
                    </TabPanel>

                </SwipeableViews>
            </TabContext>
        </Box>
    );
}
