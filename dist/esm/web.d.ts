import { WebPlugin } from '@capacitor/core';
import { AntViewerPluginPlugin } from './definitions';
export declare class AntViewerPluginWeb extends WebPlugin implements AntViewerPluginPlugin {
    constructor();
    configure(): Promise<void>;
    registerNotifications(_options: {
        fcmToken: string;
    }): Promise<{
        topic: string;
    }>;
    showFeedScreen(): Promise<void>;
    showWidget(): Promise<void>;
    hideWidget(): Promise<void>;
    setPosition(_options: {
        platform: string;
        position: string;
    }): Promise<void>;
    setMargins(_options: {
        platform: string;
        horizontal: number;
        vertical: number;
    }): Promise<void>;
    lockCapacitorControllerToPortrait(): Promise<void>;
    setLocale(_options: {
        locale: string;
    }): Promise<void>;
}
declare const AntViewerPlugin: AntViewerPluginWeb;
export { AntViewerPlugin };
