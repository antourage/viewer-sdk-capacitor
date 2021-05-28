import { WebPlugin } from '@capacitor/core';
export class AntourageWeb extends WebPlugin {
    constructor() {
        super({
            name: 'Antourage',
            platforms: ['web']
        });
    }
    configure() {
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
const Antourage = new AntourageWeb();
export { Antourage };
import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(Antourage);
//# sourceMappingURL=web.js.map