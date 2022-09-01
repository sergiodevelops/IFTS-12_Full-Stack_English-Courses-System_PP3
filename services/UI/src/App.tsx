import React, { useEffect } from "react";
import WebFont from 'webfontloader';
import Home from "@components/pages/Home/Home";

function App() {
    useEffect(() => {
        WebFont.load({
            google: {
                families: ['Nunito Sans', 'sans-serif']
            }
        });
    }, []);

    return <Home/>
}

export default App;