#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(AntourageCapacitor, "Antourage",
    CAP_PLUGIN_METHOD(registerNotifications, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(showFeedScreen, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(configure, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(showWidget, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(hideWidget, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(setPosition, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(setMargins, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(lockCapacitorControllerToPortrait, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(setLocale, CAPPluginReturnPromise);           
)

