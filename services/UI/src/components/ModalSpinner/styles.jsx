import { makeStyles } from "@material-ui/styles";

export default makeStyles(theme => ({
    containerSpinner: {
        display: 'flex',
        width: '100%',
        justifyContent: 'center',
        height: 'auto',
        alignItems: 'center',
        minHeight: '100vh',
    },
    spinner: {
        width: '20%'
    }
}));
