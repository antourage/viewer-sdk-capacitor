declare module "@capacitor/core" {
    interface PluginRegistry {
        Antourage: AntouragePlugin;
    }
}
export interface AntouragePlugin {
    configure(): Promise<void>;
    setPosition(options: {
        platform: string;
        position: string;
    }): Promise<void>;
    setMargins(options: {
        platform: string;
        horizontal: number;
        vertical: number;
    }): Promise<void>;
    lockCapacitorControllerToPortrait(): Promise<void>;
    setLocale(options: {
        locale: string;
    }): Promise<void>;
    showFeedScreen(): Promise<void>;
    showWidget(): Promise<void>;
    hideWidget(): Promise<void>;
}
