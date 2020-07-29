import { WebPlugin } from '@capacitor/core';
import { AntViewerPluginPlugin } from './definitions';

export class AntViewerPluginWeb extends WebPlugin implements AntViewerPluginPlugin {
  constructor() {
    super({
      name: 'AntViewerPlugin',
      platforms: ['web']
    });
  }

  async echo(options: { value: string }): Promise<{value: string}> {
    console.log('ECHO', options);
    return options;
  }
}

const AntViewerPlugin = new AntViewerPluginWeb();

export { AntViewerPlugin };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(AntViewerPlugin);
