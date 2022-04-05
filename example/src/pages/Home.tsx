import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  IonList,
  IonItem,
  IonCheckbox,
  IonBadge,
  IonNote,
  IonLabel,
  IonFab,
  IonFabButton,
  IonIcon,
  IonMenu,
  IonRouterOutlet,
  IonButtons,
  IonMenuButton,
  useIonViewDidEnter,
  useIonViewDidLeave,
  useIonViewWillEnter,
  useIonViewWillLeave,
} from "@ionic/react";
import { add } from "ionicons/icons";
import { RouteComponentProps } from "react-router-dom";
import React from "react";
import ExploreContainer from "../components/ExploreContainer";
import "./Home.css";
import { Plugins } from "@capacitor/core";
const { Antourage } = Plugins;

const Home: React.FC<RouteComponentProps> = (props) => {
  useIonViewDidEnter(() => {
    Antourage.showWidget();
  });

  useIonViewWillLeave(() => {
    Antourage.hideWidget();
  });

  return (
    <>
      <Menu />
      <IonPage id="main" className="home-page">
        <IonContent className="ion-padding">
          <IonList>
            <IonItem>
              <IonCheckbox slot="start" />
              <IonLabel>
                <h1>Create Idea</h1>
                <IonNote>Run Idea by Brandy</IonNote>
              </IonLabel>
              <IonBadge color="success" slot="end">
                5 Days
              </IonBadge>
            </IonItem>
            <IonItem>
              <IonCheckbox slot="start" />
              <IonLabel>
                <h1>Create Idea</h1>
                <IonNote>Run Idea by Brandy</IonNote>
              </IonLabel>
              <IonBadge color="success" slot="end">
                5 Days
              </IonBadge>
            </IonItem>
          </IonList>
          <IonFab vertical="bottom" horizontal="start" slot="fixed">
            <IonFabButton onClick={() => props.history.push("/new")}>
              <IonIcon icon={add} />
            </IonFabButton>
          </IonFab>
          <ExploreContainer />
        </IonContent>
      </IonPage>
    </>
  );
};

export default Home;

const Menu: React.FC = () => {
  const event: any = () => {};

  return (
    <>
      <IonMenu
        side="start"
        menuId="first"
        contentId="main"
        type="reveal"
        onIonDidClose={() => Antourage.showWidget()}
        onIonWillOpen={() => Antourage.hideWidget()}
      >
        <IonContent>
          <IonList style={{ marginTop: "60px" }}>
            <IonItem>Menu Item 1</IonItem>
            <IonItem>Menu Item</IonItem>
            <IonItem>Menu Item</IonItem>
            <IonItem>Menu Item</IonItem>
            <IonItem>Menu Item</IonItem>
          </IonList>
        </IonContent>
      </IonMenu>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton autoHide={false} menu="first"></IonMenuButton>
          </IonButtons>
          <IonTitle>Start Menu</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonRouterOutlet></IonRouterOutlet>
    </>
  );
};
