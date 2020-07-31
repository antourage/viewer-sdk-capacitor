import { WebPlugin } from '@capacitor/core';
import { AntViewerPluginPlugin } from './definitions';
export declare class AntViewerPluginWeb extends WebPlugin implements AntViewerPluginPlugin {
    constructor();
    auth(_options: {
        apiKey: string;
        refUserId: string;
        nickname: string;
    }): Promise<void>;
    registerNotifications(_options: {
        fcmToken: string;
    }): Promise<{
        topic: string;
    }>;
    showFeedScreen(): Promise<void>;
    showWidget(): Promise<void>;
    hideWidget(): Promise<void>;
}
declare const AntViewerPlugin: AntViewerPluginWeb;
export { AntViewerPlugin };
