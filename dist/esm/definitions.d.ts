declare module "@capacitor/core" {
    interface PluginRegistry {
        AntViewerPlugin: AntViewerPluginPlugin;
    }
}
export interface AntViewerPluginPlugin {
    auth(options: {
        apiKey: string;
        refUserId: string;
        nickname: string;
    }): Promise<void>;
    registerNotifications(options: {
        fcmToken: string;
    }): Promise<{
        topic: string;
    }>;
    showFeedScreen(): Promise<void>;
    showWidget(): Promise<void>;
    hideWidget(): Promise<void>;
}
