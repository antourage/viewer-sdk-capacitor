declare module "@capacitor/core" {
  interface PluginRegistry {
    AntViewerPlugin: AntViewerPluginPlugin;
  }
}

export interface AntViewerPluginPlugin {
  auth(options: { apiKey: string, refUserId: string, nickname: string }): Promise<void>;
  setPosition(options: { position: string }): Promise<void>;
  setMargins(options: {platform: string, horizontal: number, vertical: number }): Promise<void>;
  lockCapacitorControllerToPortrait(): Promise<void>;
  showFeedScreen(): Promise<void>;
  showWidget(): Promise<void>;
  hideWidget(): Promise<void>;
}
