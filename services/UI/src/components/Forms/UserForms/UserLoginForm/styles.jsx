import { makeStyles } from '@material-ui/core/styles';
import nosotrosImage from "@assets/images/nosotros.jpg";


export default makeStyles(theme => ({
    root: {
        // '& .MuiButton-contained.Mui-disabled':{
        //   background: '#bdc1bf',
        // },
        padding: theme.spacing(3),
    },
    titulo:{
        textAlign: "center",
    },
    formControl: {
        margin: theme.spacing(1),
        minWidth: '100%',
        '& .MuiInputBase-root':{
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
        backgroundImage: `url(${nosotrosImage})`,
    },
}));
