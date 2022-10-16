import React, {useEffect} from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import {Provider} from 'react-redux';
// import * as serviceWorker from './serviceWorker';
import store from "./store/store";
import './assets/fonts/Dangrek/Dangrek-Regular.ttf';

ReactDOM.render(
    <Provider {...{store}}>
        <React.StrictMode>
            {/*<ViewportProvider>*/}
                <App/>
            {/*</ViewportProvider>,*/}
        </React.StrictMode>
    </Provider>
    , document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
// reportWebVitals();

// serviceWorker.unregister();
