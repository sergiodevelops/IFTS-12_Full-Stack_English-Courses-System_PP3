import { combineReducers } from 'redux';
import userReducers, {UserReducersState} from "./userReducers";
import layoutReducers, {LayoutReducersState} from "./layoutReducers";
// import notificationReducers from "./notificationReducers";


export interface RootState {
    userReducers: UserReducersState,
    layoutReducers: LayoutReducersState,
    // notificationReducers: NotificationReducersState,
}

export default combineReducers({
    userReducers: userReducers,
    layoutReducers: layoutReducers,
    // notificationReducers: notificationReducers,
})
