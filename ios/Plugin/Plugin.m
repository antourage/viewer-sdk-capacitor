#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(AntourageCapacitor, "Antourage",
           CAP_PLUGIN_METHOD(configure, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(registerNotifications, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(unregisterNotifications, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(showWidget, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(hideWidget, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setBottomMargin, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setPortalColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setNameTextColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setNameBackgroundColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setTitleTextColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setTitleBackgroundColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setCtaTextColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setCtaBackgroundColor, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setLiveDotColor, CAPPluginReturnPromise);
)

