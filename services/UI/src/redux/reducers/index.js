import { combineReducers } from 'redux';
import userReducers from "./userReducers";
import layoutReducers from "./layoutReducers";
// import notificationReducers from "./notificationReducers";

export default combineReducers({
    userReducers: userReducers,
    layoutReducers: layoutReducers,
    // notificationReducers: notificationReducers,
})