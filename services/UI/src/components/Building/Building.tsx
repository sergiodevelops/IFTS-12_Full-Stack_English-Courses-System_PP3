import React from 'react';
import buildingImg from '@assets/images/building.gif'
import useStyles from "./styles";

export default function Building() {
    const classes = useStyles();

    return(
        <div className={classes.root}>
            <img className={'buildingImg'} src={buildingImg} alt="Logo" />
        </div>
    )
}
