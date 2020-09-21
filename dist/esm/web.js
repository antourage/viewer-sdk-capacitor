import { WebPlugin } from '@capacitor/core';
export class AntViewerPluginWeb extends WebPlugin {
    constructor() {
        super({
            name: 'AntViewerPlugin',
            platforms: ['web']
        });
    }
    auth(_options) {
        throw new Error("Method not implemented.");
    }
    registerNotifications(_options) {
        throw new Error("Method not implemented.");
    }
    showFeedScreen() {
        throw new Error("Method not implemented.");
    }
    showWidget() {
        throw new Error("Method not implemented.");
    }
    hideWidget() {
        throw new Error("Method not implemented.");
    }
    setPosition(_options) {
        throw new Error("Method not implemented.");
    }
    setMargins(_options) {
        throw new Error("Method not implemented.");
    }
    lockCapacitorControllerToPortrait() {
        throw new Error("Method not implemented.");
    }
    setLocale(_options) {
        throw new Error("Method not implemented.");
    }
}
const AntViewerPlugin = new AntViewerPluginWeb();
export { AntViewerPlugin };
import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(AntViewerPlugin);
//# sourceMappingURL=web.js.map