import React from "react";
import ReactDOM from "react-dom";
import App from "./App";
import * as serviceWorker from "./serviceWorker";
import { Plugins } from "@capacitor/core";
const { Antourage } = Plugins;

const render = () => {
  Antourage.configure({ teamId: 1 });

  /**
   * Library method samples

  // Antourage.setPortalColor({ color: "#FF0000" });
  // Antourage.setCtaBackgroundColor({ color: "#000000" });
  // Antourage.setCtaTextColor({ color: "#FF0000" });
  // Antourage.setLiveDotColor({ color: "#FFFFFF" });
  // Antourage.setTitleTextColor({ color: "#FFFFFF" });
  // Antourage.setTitleBackgroundColor({ color: "#000000" });
  // Antourage.setNameTextColor({ color: "#FFFFFF" });
  // Antourage.setNameBackgroundColor({ color: "#000000" });
  // Antourage.setBottomMargin({ margin: 0 });

 */

  ReactDOM.render(<App />, document.getElementById("root"));
};

render();

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
