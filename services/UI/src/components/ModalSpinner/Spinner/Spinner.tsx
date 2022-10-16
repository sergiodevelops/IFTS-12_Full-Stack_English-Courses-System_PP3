import React from "react";
import {CircularProgress} from "@material-ui/core";
import useStyles from "./styles";

export default function Spinner(props: { style? :any}){
    const classes = useStyles();

    return(
        <div style={props.style} className={classes.containerSpinner}>
            <CircularProgress
                className={classes.spinner}
                 size={'20vh'}
            />
        </div>
    )
}
