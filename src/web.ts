import { WebPlugin } from "@capacitor/core";
import { AntouragePlugin } from "./definitions";

export class AntourageWeb extends WebPlugin implements AntouragePlugin {
  constructor() {
    super({
      name: "Antourage",
      platforms: ["web"],
    });
  }
  configure(_options: { teamId: number }): Promise<void> {
    throw new Error("Method not implemented.");
  }

  setPortalColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setCtaBackgroundColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setCtaTextColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setLiveDotColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setTitleTextColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setTitleBackgroundColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setNameTextColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setNameBackgroundColor(_options: { color: string }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  registerNotifications(_options: {
    fcmToken: string;
  }): Promise<{ topic: string }> {
    throw new Error("Method not implemented.");
  }
  showWidget(): Promise<void> {
    throw new Error("Method not implemented.");
  }
  hideWidget(): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setBottomMargin(_options: {
    platform: string;
    margin: number;
  }): Promise<void> {
    throw new Error("Method not implemented.");
  }
}

const Antourage = new AntourageWeb();

export { Antourage };

import { registerWebPlugin } from "@capacitor/core";
registerWebPlugin(Antourage);
