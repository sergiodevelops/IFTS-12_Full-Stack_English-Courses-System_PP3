import { makeStyles } from '@material-ui/core/styles';
import principalImage from "@assets/images/objetivo.jpeg";
import nosotrosImage from "@assets/images/nosotros.jpg";

export default makeStyles(theme => ({
    container: {
        padding: theme.spacing(3),
    },
    backImage: {
        height: "100vh",
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
    },
    nosotros:{
        backgroundImage: `url(${nosotrosImage})`,
    },
    principal:{
        backgroundImage: `url(${principalImage})`,
    },

}));
