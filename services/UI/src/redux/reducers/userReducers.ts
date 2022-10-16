import IUserLoginResDto
    from "@usecases/user/login/IUserLoginResDto";
import {TYPES} from "@redux/actions/userActions";

export type UserReducersState = {
    usersList: IUserLoginResDto[],
    currentUser: IUserLoginResDto | undefined,
}

export type ActionProps = {
    type: string,
    payload?: {
        usersList?: IUserLoginResDto[],
        currentUser?: IUserLoginResDto | null,
    }
}

export default (
    state: UserReducersState = {
        usersList: [],
        currentUser: undefined
    },
    action: ActionProps) => {

    switch (action.type) {
        case TYPES.ADD_NEW_USER:
            const userExist = state.usersList.findIndex((user: IUserLoginResDto) =>
                user.username === action.payload?.currentUser?.username
            ) !== -1;
            // si vino (vacio o null) o usuario ya existe en la DB
            if (!action.payload?.currentUser || userExist) return state; // no hace nada
            // si no existe aun el usuario a crear, lo crea
            if (!userExist) return {...state,usersList: [...state.usersList, action.payload.currentUser]};
            return state;
        case TYPES.SET_CURRENT_AUTHENTICATED_USER:
            if (!action.payload?.currentUser) return {
                ...state,
                currentUser: null
            }; // no hace nada
            // const currentUserData = state.usersList.find((user) =>
            //     user.username === action.payload.user.username && user.password === action.payload.user.password);
            // return {...state,currentUser: currentUserData};
            return {...state, currentUser: action.payload?.currentUser};
        default:
            return state;
    }
}
