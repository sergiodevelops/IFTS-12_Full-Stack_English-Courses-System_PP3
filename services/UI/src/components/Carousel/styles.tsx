import { makeStyles } from '@material-ui/core/styles';

export default makeStyles(() => ({
    root:{
        minHeight: '100vh',
        backgroundColor: 'black',
        "& .carousel-caption":{
            minHeight: '100vh',
            display: "flex",
            flexDirection: "column",
            justifyContent: "end",
            paddingBottom: "7%"
        }
    },
    imagen:{
        minHeight: '100vh',
        opacity: "0.3"
    },
}));
