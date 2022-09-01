import {ActionProps, Dimensions} from "@redux/reducers/layoutReducers";

export const TYPES = {
    SET_SUBMENU_TAB_VALUE: 'SET_SUBMENU_TAB_VALUE',
    SET_MAIN_TAB_VALUE: 'SET_MAIN_TAB_VALUE',
    SET_APP_BAR_DIMENSIONS: 'SET_APP_BAR_DIMENSIONS',
    SET_FOOTER_DIMENSIONS: 'SET_FOOTER_DIMENSIONS',
    SET_OPEN_MODAL: 'SET_OPEN_MODAL',
}

const setSubMenuTabValue = (subMenuTabValueStore: string): ActionProps => {
    return {
        type: TYPES.SET_SUBMENU_TAB_VALUE,
        payload: {
            subMenuTabValueStore: subMenuTabValueStore,
        },
    };
}
const setMainTabValue = (mainTabValueStore: string): ActionProps => {
    return {
        type: TYPES.SET_MAIN_TAB_VALUE,
        payload: {
            mainTabValueStore: mainTabValueStore,
        },
    };
}
const setAppBarDimensions = (appBarDimensions: Dimensions): ActionProps => {
    return {
        type: TYPES.SET_APP_BAR_DIMENSIONS,
        payload: {
            appBarDimensions: appBarDimensions,
        },
    };
}
const setFooterDimensions = (footerDimensions: Dimensions): ActionProps => {
    return {
        type: TYPES.SET_FOOTER_DIMENSIONS,
        payload: {
            footerDimensions: footerDimensions,
        },
    };
}
const setOpenModal = (openModal: boolean): ActionProps => {
    return {
        type: TYPES.SET_OPEN_MODAL,
        payload: {
            openModal,
        },
    };
}

export default {
    setSubMenuTabValue: setSubMenuTabValue,
    setMainTabValue: setMainTabValue,
    setAppBarDimensions: setAppBarDimensions,
    setFooterDimensions: setFooterDimensions,
    setOpenModal: setOpenModal,
};
