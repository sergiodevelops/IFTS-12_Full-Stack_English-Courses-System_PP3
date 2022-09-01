export type Dimensions = {
    width: number,
    height: number,
}

export type LayoutReducersState = {
    subMenuTabValueStore: string,
    mainTabValueStore: string,
    appBarDimensions: Dimensions,
    footerDimensions: Dimensions,
    openModal: boolean,
}

export type ActionProps = {
    type: string,
    payload?: {
        subMenuTabValueStore?: string,
        mainTabValueStore?: string,
        appBarDimensions?: Dimensions,
        footerDimensions?: Dimensions,
        openModal?: boolean,
    }
}

export default (
    state: LayoutReducersState = {
        subMenuTabValueStore: "0",
        mainTabValueStore: "0",
        appBarDimensions: {width:64,height:0},
        footerDimensions: {width:240,height:0},
        openModal: false,
    },
    action: ActionProps) => {
    switch (action.type) {
        case "SET_SUBMENU_TAB_VALUE":
            if (!action.payload?.subMenuTabValueStore) return state; // no hace nada
            return {...state, subMenuTabValueStore: action.payload.subMenuTabValueStore};
        case "SET_MAIN_TAB_VALUE":
            if (!action.payload?.mainTabValueStore ) return state; // no hace nada
            return {...state, mainTabValueStore: action.payload.mainTabValueStore};
        case "SET_APP_BAR_DIMENSIONS":
            if (!action.payload?.appBarDimensions ) return state; // no hace nada
            return {...state, appBarDimensions: action.payload.appBarDimensions};
        case "SET_FOOTER_DIMENSIONS":
            if (!action.payload?.footerDimensions ) return state; // no hace nada
            return {...state, footerDimensions: action.payload.footerDimensions};
        case "SET_OPEN_MODAL":
            return {...state, openModal: action?.payload?.openModal};
        default:
            return state;
    }
}
