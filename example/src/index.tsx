import React from "react";
import ReactDOM from "react-dom";
import App from "./App";
import * as serviceWorker from "./serviceWorker";
import { Plugins } from "@capacitor/core";
const { Antourage } = Plugins;

const render = () => {
  Antourage.configure();

  Antourage.addListener("onViewerAppear", (info: any) => {
    console.log("ios viewer did appear");
    // window.screen.orientation.unlock();
  });

  Antourage.addListener("onViewerDisappear", (info: any) => {
    console.log("ios viewer did disappear");
    //window.screen.orientation.lock('portrait');
  });

  Antourage.setPosition({ position: "bottomRight" });
  Antourage.setLocale({ locale: "en" });
  Antourage.setMargins({ horizontal: 10, vertical: 80 });
  // Antourage.lockCapacitorControllerToPortrait();

  ReactDOM.render(<App />, document.getElementById("root"));
};

render();

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
