import { WebPlugin } from '@capacitor/core';
import { AntViewerPluginPlugin } from './definitions';

export class AntViewerPluginWeb extends WebPlugin implements AntViewerPluginPlugin {
  constructor() {
    super({
      name: 'AntViewerPlugin',
      platforms: ['web']
    });
  }
  auth(_options: { apiKey: string; refUserId: string; nickname: string; }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  registerNotifications(_options: { fcmToken: string; }): Promise<{ topic: string; }> {
    throw new Error("Method not implemented.");
  }
  showFeedScreen(): Promise<void> {
    throw new Error("Method not implemented.");
  }
  showWidget(): Promise<void> {
    throw new Error("Method not implemented.");
  }
  hideWidget(): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setPosition(_options: { position: string; }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setMargins(_options: {platform: string; horizontal: number; vertical: number; }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  lockCapacitorControllerToPortrait(): Promise<void> {
    throw new Error("Method not implemented.");
  }
}

const AntViewerPlugin = new AntViewerPluginWeb();

export { AntViewerPlugin };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(AntViewerPlugin);
