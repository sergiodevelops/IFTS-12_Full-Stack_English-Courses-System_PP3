import {makeStyles} from '@material-ui/core/styles';
import principalImage from "@assets/images/institute.jpeg";
import nosotrosImage from "@assets/images/nosotros.jpg";

export default makeStyles(theme => ({
    root: {
        '& .css-1t29gy6-MuiToolbar-root':{
            minHeight: "0",
        },
        '& .css-1h9z7r5-MuiButtonBase-root-MuiTab-root.Mui-selected': {
            color: "#ffffff",
            fontWeight: "bolder",
        },
        display: "flex",
        justifyContent: "space-between",
    },
    '& .css-1y942vo-MuiButtonBase-root-MuiButton-root': {
        padding: "0",
        color: "#ffffff",
        margin: "0 40px"
    },

    '& .css-hip9hq-MuiPaper-root-MuiAppBar-root': {
        color: "#ffffff",
        borderColor: "transparent",
        borderBottomWidth: "0"
    },
    '& .css-1gsv261': {
        color: "#ffffff",
        borderColor: "transparent",
        borderBottomWidth: "0"
    },
    '& .makeStyles-tabs-48': {
        borderColor: "transparent",
        color: "#ffffff",
        borderBottomWidth: "0"
    },
    '& .css-1t29gy6-MuiToolbar-root': {
        padding: "0",
        margin: "0 40px",
        height: "100%"
    },
    tabs: {

        color: "white !important",
    },
    toolbar: {
        '& .css-1h9z7r5-MuiButtonBase-root-MuiTab-root.Mui-selected': {
            color: "#ffffff",
            fontWeight: "bolder",
        },
        display: "flex",
        justifyContent: "space-between",
    },
    titleLogoContainer: {
        cursor: "pointer",
        display: "flex",
        minHeight: "40px"
    },
    logo: {
        width: "40px"
    },
}));
