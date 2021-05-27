package com.antourage.plugin;

import android.app.Activity;
import android.content.Intent;
import android.view.ViewGroup;

import com.antourage.weaverlib.screens.base.AntourageActivity;
import com.antourage.weaverlib.ui.fab.AntourageFab;
import com.antourage.weaverlib.ui.fab.RegisterPushNotificationsResult;
import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

@NativePlugin()
public class AntViewerPlugin extends Plugin {
    private AntourageFab antFab;

    // @PluginMethod()
    // public void auth(PluginCall call) {
    //     String apiKey = call.getString("apiKey");

    //     if (apiKey == null || apiKey.isEmpty()) {
    //         call.reject("Must provide an apiKey");
    //         return;
    //     }

    //     String refUserId = call.getString("refUserId");
    //     String nickname = call.getString("nickname");

    //     this.getActivity().runOnUiThread(() -> {
    //         if (antFab == null) {
    //             antFab = new AntourageFab(getActivity());
    //         }
    //         AntourageFab.Companion.authWith(apiKey, refUserId, nickname, getActivity());
    //         call.resolve();
    //     });
    // }

    @PluginMethod()
    public void configure(PluginCall call) {

    }

    @PluginMethod()
    public void setPosition(PluginCall call) {
        String position = call.getString("position");
        if (call.getString("platform") == "ios") {
            return;
        }
        if (position == null || position.isEmpty()) {
            call.reject("Must provide valid position");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            if (antFab != null) antFab.setPosition(position);
        });
    }

    @PluginMethod()
    public void setMargins(PluginCall call) {
        Integer horizontal = call.getInt("horizontal");
        Integer vertical = call.getInt("vertical");
        if (call.getString("platform") == "ios" || horizontal == null || vertical == null) {
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            if (antFab != null) antFab.setMargins(horizontal, vertical);
        });

    }

    @PluginMethod()
    public void lockCapacitorControllerToPortrait(PluginCall call) {
    } //iOS only

    @PluginMethod()
    public void showFeedScreen(PluginCall call) {
        Intent intent = new Intent(getContext(), AntourageActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        getActivity().startActivity(intent);
    }

    @PluginMethod()
    public void registerNotifications(PluginCall call) {
        String fcmToken = call.getString("fcmToken");

        if (fcmToken == null || fcmToken.isEmpty()) {
            call.reject("Must provide an fcmToken");
            return;
        }

        AntourageFab.Companion.registerNotifications(fcmToken, result -> {
            if (result instanceof RegisterPushNotificationsResult.Failure) {
                call.reject(((RegisterPushNotificationsResult.Failure) result).getCause());
            } else if (result instanceof RegisterPushNotificationsResult.Success) {
                JSObject json = new JSObject();
                json.put("topic", ((RegisterPushNotificationsResult.Success) result).getTopicName());
                call.resolve(json);
            }
            return null;
        });
    }


    @PluginMethod()
    public void showWidget(PluginCall call) {
        this.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Activity activity = getActivity();
                if (antFab == null) {
                    antFab = new AntourageFab(activity);
                }
                if (antFab.getParent() == null) {
                    antFab.showFab(activity);
                    antFab.onResume();
                }
            }
        });
    }

    @PluginMethod()
    public void hideWidget(PluginCall call) {
        this.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Activity activity = getActivity();
                ViewGroup viewGroup = (ViewGroup) ((ViewGroup) activity.findViewById(android.R.id.content)).getChildAt(0);
                antFab.onPause();
                viewGroup.removeView(antFab);
            }
        });
    }

    @PluginMethod()
    public void onPause() {
        if (antFab != null) antFab.onPause();
    }

    @PluginMethod()
    public void onResume() {
        if (antFab != null) antFab.onResume();
    }

    @PluginMethod()
    public void setLocale(PluginCall call) {
        this.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                String lang = call.getString("locale");
                if (antFab != null) antFab.setLocale(lang);
            }
        });
    }

}
