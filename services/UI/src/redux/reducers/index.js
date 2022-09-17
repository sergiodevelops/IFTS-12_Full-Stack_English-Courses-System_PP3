import { combineReducers } from 'redux';
import userReducers from "./userReducers";
import layoutReducers from "./layoutReducers";
// import notificationReducers from "./notificationReducers";

exports = combineReducers({
    userReducers: userReducers,
    layoutReducers: layoutReducers,
    // notificationReducers: notificationReducers,
})