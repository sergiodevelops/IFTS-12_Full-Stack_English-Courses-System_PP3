import {makeStyles} from '@material-ui/core/styles';

export default makeStyles(theme => ({
    newsTitle: {
        ...theme.typography.h4,
        padding: theme.spacing(1),
        textAlign: 'center',
        color: theme.palette.text.secondary,
    },
    container: {
        margin: theme.spacing(1),
        backgroundColor: "#4a3bb60f",
    },
    main: {
        height: "100vh",
        backgroundColor: "rgba(255,255,255,0.53)",
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
    },
    msgQueryResults:{
        color: '#ff000073',
    },
}));
