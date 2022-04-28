declare module "@capacitor/core" {
  interface PluginRegistry {
    Antourage: AntouragePlugin;
  }
}

export interface AntouragePlugin {
  configure(options: { teamId: number }): Promise<void>;
  setPortalColor(options: { color: string }): Promise<void>;
  setCtaBackgroundColor(options: { color: string }): Promise<void>;
  setCtaTextColor(options: { color: string }): Promise<void>;
  setLiveDotColor(options: { color: string }): Promise<void>;
  setTitleTextColor(options: { color: string }): Promise<void>;
  setTitleBackgroundColor(options: { color: string }): Promise<void>;
  setNameTextColor(options: { color: string }): Promise<void>;
  setNameBackgroundColor(options: { color: string }): Promise<void>;
  setBottomMargin(options: { platform: string; margin: number }): Promise<void>;
  registerNotifications(options: { fcmToken: string; }): Promise<{ topic: string }>;
  unregisterNotifications(): Promise<void>;
  showWidget(): Promise<void>;
  hideWidget(): Promise<void>;
}
