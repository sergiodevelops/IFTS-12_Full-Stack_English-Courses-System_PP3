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
const colorCurrentButtonMenu = '#007bff26';

    return (
        <Box
            sx={{
                width: '100%',
                typography: 'body1'
            }}
        >
            <TabContext value={subMenuTab}>
                {/*SubMenues de CONSULTAS [0 a 4]*/}
                <SwipeableViews index={parseInt(subMenuTab)} className={classes.subMenuItems}>

                    {/*SubMenues de ABM [0 a 4]*/}
                    <TabPanel tabIndex={parseInt(subMenuTab)} value="0">
                        <List>
                            {[
                                'Usuarios Alumnos',
                                'Usuarios Docentes',
                                'Usuarios Administrativos',
                                'Alumnos',
                                'Anuncios',
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

                    {/*SubMenues de ABM [5 a 8]*/}
                    <TabPanel tabIndex={parseInt(subMenuTab)} value="1">
                        <List>
                            {[
                                'Usuario',
                                'Anuncio',
                                'Información de Alumno',
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
