import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import * as serviceWorker from './serviceWorker';
import { Plugins } from '@capacitor/core';
const { AntViewerPlugin } = Plugins;

const render = () => {
    AntViewerPlugin.auth({
        apiKey: "put_your_apiKey_there",
        refUserId: "put_user_id_from_your_base_or_null",
        nickname: "put_user_nickname_from_your_base_or_null"
    })
        .then(() => {
            console.log("Success");
        })
        .catch((error: any) => {
            console.log(error);
        });
    ReactDOM.render(<App />, document.getElementById('root'));
}

render();

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
