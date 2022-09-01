import { makeStyles } from '@material-ui/core/styles';

import misionImage from '@assets/images/principal.jpeg';
import visionImage from '@assets/images/vision.jpeg';
import objetivoImage from '@assets/images/objetivo.jpeg';
import nosotrosImage from '@assets/images/nosotros.jpg';

export default makeStyles(() => ({
    root:{
        '& .css-13xfq8m-MuiTabPanel-root':{
            padding: '0',
        },
    },
    singlePageContentList:{
        '& .css-13xfq8m-MuiTabPanel-root':{
            padding: '0',
        },
    },
    spaTitle:{
        margin:'10px 0px',
    },
    welcomeTitle:{
        textAlign: "center",
    },
    mision:{
        height: "100vh",
        backgroundImage: `url(${misionImage})`,
    },
    vision:{
        height: "100vh",
        backgroundImage: `url(${visionImage})`,
    },
    objetivo:{
        height: "100vh",
        backgroundImage: `url(${objetivoImage})`,
    },
    nosotros:{
        height: "100vh",
        backgroundImage: `url(${nosotrosImage})`,
    },
    parrafo:{
        margin: '0% 10%',
        fontSize:'1.5rem',
        color: 'black',
    },
    backImage: {
        height: "100vh",
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
    },
}));
