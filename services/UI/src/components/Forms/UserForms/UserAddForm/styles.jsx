import { makeStyles } from '@material-ui/core/styles';
import principalImage from "@assets/images/principal.jpeg";

export default makeStyles(theme => ({
    root: {
        padding: theme.spacing(3),
    },
    addFormTitle:{
        textAlign: "center",
        margin:'10px 0px',
    },
    formControl: {
        minWidth: '100%',
        '& .MuiAutocomplete-root':{
            minWidth: '100%',
        },
    },
    selectEmpty: {
        marginTop: theme.spacing(2),
    },
    backImage: {
        height: "100vh",
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
    },
    nosotros:{
        height: "100vh",
        backgroundImage: `url(${principalImage})`,
    },
}));
