import { WebPlugin } from '@capacitor/core';
import { AntouragePlugin } from './definitions';

export class AntourageWeb extends WebPlugin implements AntouragePlugin {
  constructor() {
    super({
      name: 'Antourage',
      platforms: ['web']
    });
  }
  configure(): Promise<void> {
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
  setPosition(_options: { platform: string; position: string; }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setMargins(_options: { platform: string; horizontal: number; vertical: number; }): Promise<void> {
    throw new Error("Method not implemented.");
  }
  lockCapacitorControllerToPortrait(): Promise<void> {
    throw new Error("Method not implemented.");
  }
  setLocale(_options: { locale: string; }): Promise<void> {
    throw new Error("Method not implemented.");
  }
}

const Antourage = new AntourageWeb();

export { Antourage };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(Antourage);
