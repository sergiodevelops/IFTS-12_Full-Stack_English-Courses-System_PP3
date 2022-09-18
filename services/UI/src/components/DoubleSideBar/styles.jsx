import {makeStyles} from '@material-ui/core/styles';

export default makeStyles(() => ({
    root: {
        '& .css-1e6y48t-MuiButtonBase-root-MuiButton-root':{
          color: "white"
        },
        '& .css-1t29gy6-MuiToolbar-root':{
          minHeight: "0",
        },
        '& .css-9g7ou3-MuiPaper-root-MuiAppBar-root':{
            backgroundColor: "#3f51b5",
        },
        '& .css-1h2de3g-MuiPaper-root-MuiAppBar-root':{
            backgroundColor: "#3f51b5",
        },
        '& .css-eenbiz-MuiPaper-root-MuiAppBar-root':{
            backgroundColor: "#3f51b5",
        },
        '& main .css-1mbri1u': {
            display: "none",
        },
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
