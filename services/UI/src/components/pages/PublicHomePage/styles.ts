import {makeStyles} from '@material-ui/core/styles';
// import principalImage from "@assets/images/institute.jpeg";
// import nosotrosImage from "@assets/images/nosotros.jpg";

export default makeStyles(theme => ({
    content: {
        // backgroundImage: `url(${principalImage})`,
        minHeight: "95vh",
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
        backgroundColor: "#ffffff"
    },
    root: {

        '& .css-19kzrtu': {
           padding: "0",
        },

        '& .css-hip9hq-MuiPaper-root-MuiAppBar-root': {
            backgroundColor: "#3f51b5",
        }
    }

}));
