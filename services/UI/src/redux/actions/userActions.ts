import IUserLoginResDto from "@usecases/user/login/IUserLoginResDto"
import {ActionProps} from "@redux/reducers/userReducers";

export const TYPES = {
    ADD_NEW_USER: 'ADD_NEW_USER',
    SET_CURRENT_AUTHENTICATED_USER: 'SET_CURRENT_AUTHENTICATED_USER',
}

const addNewUser = (currentUser: IUserLoginResDto): ActionProps => {
    return {
        type: TYPES.ADD_NEW_USER,
        payload: {
            currentUser,
        },
    };
}
const setCurrentAuthenticatedUser = (currentUser: IUserLoginResDto | null): ActionProps => {
    return {
        type: TYPES.SET_CURRENT_AUTHENTICATED_USER,
        payload: {
            currentUser,
        },
    };
}

export default {
    addNewUser,
    setCurrentAuthenticatedUser,
};
