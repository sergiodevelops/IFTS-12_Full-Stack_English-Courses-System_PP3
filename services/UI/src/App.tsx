import React, {useEffect, useState} from "react";
import WebFont from 'webfontloader';
import Login from "@components/pages/Login/Login";
import PublicHomePage from "@components/pages/PublicHomePage/PublicHomePage";
import ReactDOM from "react-dom";
import {
    Routes,
    Route,
    BrowserRouter,
} from "react-router-dom";
import {useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import {Navigate} from 'react-router-dom';
import PrivateCampus from "@components/DoubleSideBar/PrivateCampus";

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
            </Routes>
        </BrowserRouter>
    )
}

export default App;