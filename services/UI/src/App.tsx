import React, {useEffect, useState} from "react";
import WebFont from 'webfontloader';
import Login from "@components/Pages/Login/Login";
import PublicHomePage from "@components/Pages/PublicHomePage/PublicHomePage";
import ReactDOM from "react-dom";
import {
    Routes,
    Route,
    BrowserRouter,
    Link,
} from "react-router-dom";
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import {Navigate} from 'react-router-dom';
import PrivateCampus from "@components/PrivateCampus/PrivateCampus";
import layoutActions from "@redux/actions/layoutActions";

function App() {
    // usuario esta logueado o no?
    const userIsLoggedIn: boolean = !!useSelector((state: RootState) => state?.userReducers.currentUser);
    const [sesionActiva, setSesionActiva] = useState<boolean>(userIsLoggedIn);


    useEffect(() => {
        WebFont.load({
            google: {
                families: ['Nunito Sans', 'sans-serif']
            }
        });
    }, []);

    useEffect(() => {
        setSesionActiva(userIsLoggedIn)
    }, [userIsLoggedIn]);


    return (
        <BrowserRouter>
            <Routes>
                <Route path={"/*"} element={<Navigate replace to={"/"}/>}/>
                <Route path={"/"} element={<PublicHomePage/>}/>
                <Route path={"/login"} element={<PublicHomePage isAdmin={true}/>}/>
            </Routes>
        </BrowserRouter>
    )
}

export default App;