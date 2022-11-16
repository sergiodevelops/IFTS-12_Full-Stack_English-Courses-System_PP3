import {makeStyles} from '@material-ui/core/styles';
import building from "@assets/images/building.png";
// import nosotrosImage from "@assets/images/nosotros.jpg";

export default makeStyles(theme => ({
    root: {
        '& .css-19kzrtu': {
            padding: "0",
        },
        '& .css-hip9hq-MuiPaper-root-MuiAppBar-root': {
            backgroundColor: "#3f51b5",
        }
    },
    contactTitle: {
        ...theme.typography.h4,
        padding: theme.spacing(1),
        textAlign: 'center',
        color: theme.palette.text.secondary,
    },
    inicio: {
    },
    nosotros: {
    },
    content: {
        minHeight: "95vh",
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
        backgroundColor: "#ffffff"
    },
    building: {
        backgroundImage: `url(${building})`,
    },
}));
