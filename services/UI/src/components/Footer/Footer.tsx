import React, { useCallback, useEffect } from 'react';
import layoutActions from '@redux/actions/layoutActions';
import { useDispatch } from 'react-redux';
import { useResizeDetector } from 'react-resize-detector';
import useStyles from './styles';

export default function Footer(props: {
    openLeft?: boolean;
    openRight?: boolean;
    drawerWidth?: number;
}) {
    const dispatch = useDispatch();
    const classes = useStyles();
    const { openLeft, openRight, drawerWidth } = props;
    // CORRECT - `useCallback` approach
    //https://www.npmjs.com/package/react-resize-detector
    const onResize = useCallback(() => {}, []);
    const { ref, width, height } = useResizeDetector({ onResize });
    useEffect(() => {
        let newFooterDimensions = { width: 600, height: 600 };
        newFooterDimensions = {
            ...newFooterDimensions,
            width: width ? width : newFooterDimensions.width,
            height: height ? height : newFooterDimensions.height,
        };
        dispatch(layoutActions.setFooterDimensions(newFooterDimensions));
    }, [width, height]);

    return (
        <footer
            ref={ref}
            className={`${classes.root}`}
            style={{
                paddingLeft:
                    openLeft && drawerWidth ? `${drawerWidth + 25}px` : `25px`,
                paddingRight:
                    openRight && drawerWidth ? `${drawerWidth + 25}px` : `25px`,
            }}
        >
            <p className={classes.copyright}>
                Copyright 2022 TTJ Development Team. All rights reserved.
            </p>
        </footer>
    );
}
