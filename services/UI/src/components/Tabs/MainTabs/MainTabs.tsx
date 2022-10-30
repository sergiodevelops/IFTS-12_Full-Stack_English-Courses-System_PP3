import React, {useEffect, useState} from 'react';
import Box from '@mui/material/Box';
import TabContext from '@mui/lab/TabContext';
import TabPanel from '@mui/lab/TabPanel';
import {useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import Typography from "@mui/material/Typography";
import singlePageContentList from "@constants/mainTabsContent";
import ISinglePageContentDto
    from "@usecases/singlePage/list/ISinglePageContentDto";
import useStyles from "./styles";
import TableData from "@components/TableData/TableData";
import Building from "@components/Building/Building";
import Grid from "@material-ui/core/Grid";
import UserAddForm from "@components/Forms/UserForms/UserAddForm/UserAddForm";
import SwipeableViews from "react-swipeable-views";
import {ClassNameMap} from "@material-ui/styles";
import NewAddForm from '@components/Forms/NewForms/NewAddForm/NewAddForm';
import ApplicantAddForm
    from "@components/Forms/ApplicantForms/ApplicantAddForm/ApplicantAddForm";
import CourseAddForm
    from "@components/Forms/CourseForms/CourseAddForm/CourseAddForm";
import NewsPosts from "@components/Pages/NewsPosts/NewsPosts";

function MainTitle(props: { classes: ClassNameMap<"objetivo" | "singlePageContentList" | "vision" | "parrafo" | "welcomeTitle" | "root" | "nosotros" | "spaTitle" | "mision" | "backImage">, content: ISinglePageContentDto }) {
    return <Typography variant={"h4"}
                       noWrap
                       className={props.classes.spaTitle}
                       component={"div"}
                       textAlign={"center"}
                       paddingY={"2vh"}
    >
        {props.content.title}
    </Typography>;
}

export default function MainTabs(props: { isWelcomePage: boolean }) {
    const [isWelcomePage, setIsWelcomePage] = useState(props.isWelcomePage);
    const classes = useStyles();
    const mainTabValueStore = useSelector((state: RootState) => state.layoutReducers.mainTabValueStore);
    const [loadTable, setLoadTable] = useState<boolean>(true);
    const [menuTab, setMenuTab] = useState("0");
    const currentUser = useSelector((state: RootState) => state?.userReducers.currentUser);

    useEffect(() => {
        if (menuTab !== mainTabValueStore) {
            setMenuTab(mainTabValueStore);
        }
    }, [mainTabValueStore]);

    function WelcomeUserTitle(props: { fullnameUserAuth?: string }) {
        return (
            <Grid className={`${classes.backImage} ${classes.nosotros}`}>
                <Typography variant={"h5"}
                            noWrap
                            className={classes.welcomeTitle}
                            component={"div"}
                            textAlign={'center'}
                            color={'grey'}
                            // marginY={'2vh'}
                >
                    Hola {props.fullnameUserAuth?.toUpperCase()}
                    <br/>
                    Bienvenidos al portal del Instituto !
                </Typography>
            </Grid>
        )
    }

    return (
        <Box
            className={classes.root}
            // sx={{width: '100%', typography: 'body1'}}
        >
            <TabContext value={menuTab}>
                {
                    isWelcomePage ?
                        <div>
                            <WelcomeUserTitle
                                fullnameUserAuth={currentUser?.nombre_completo}
                            />
                        </div> :
                        <SwipeableViews index={parseInt(mainTabValueStore)}>
                            {
                                singlePageContentList
                                    .map((content: ISinglePageContentDto, index: number) => {
                                        return (
                                            <TabPanel
                                                className={classes.singlePageContentList}
                                                key={`singlePageContentList-${index}`}
                                                value={index.toString()}
                                            >
                                                {content.moduleName === 'Building' &&
                                                    <div>
                                                        {!!content.title &&
                                                        <MainTitle classes={classes}
                                                                   content={content}/>}
                                                        <Building/>
                                                    </div>}

                                                {content.moduleName === 'TableData' &&
                                                <div>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <TableData/>
                                                </div>}

                                                {content.moduleName === 'NewsPosts' &&
                                                <div>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <TableData/>
                                                </div>}

                                                {content.moduleName === 'UserAddForm' &&
                                                <div>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <UserAddForm title={""}/>
                                                </div>}

                                                {content.moduleName === 'JobAdAddForm' &&
                                                <div>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <NewAddForm title={""}/>
                                                </div>}

                                                {content.moduleName === 'ApplicantAddForm' &&
                                                <div>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <ApplicantAddForm title={""}/>
                                                </div>}

                                                {content.moduleName === 'CourseAddForm' &&
                                                <div>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <CourseAddForm title={""}/>
                                                </div>}

                                                {content.moduleName === 'Mision' &&
                                                <div className={`${classes.backImage} ${classes.mision}`}>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <p className={classes.parrafo}>{content.body}</p>
                                                </div>}

                                                {content.moduleName === 'Vision' &&
                                                <div
                                                    className={`${classes.backImage} ${classes.vision}`}>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <p className={classes.parrafo}>{content.body}</p>
                                                </div>}

                                                {content.moduleName === 'Objetivo' &&
                                                <div
                                                    className={`${classes.backImage} ${classes.objetivo}`}>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <p className={classes.parrafo}>{content.body}</p>
                                                </div>}

                                                {content.moduleName === 'Nosotros' &&
                                                <div
                                                    className={`${classes.backImage} ${classes.nosotros}`}>
                                                    {!!content.title &&
                                                    <MainTitle classes={classes}
                                                               content={content}/>}
                                                    <p className={classes.parrafo}>{content.body}</p>
                                                </div>}

                                            </TabPanel>
                                        )
                                    })
                            }
                        </SwipeableViews>
                }
            </TabContext>
        </Box>
    );
}
