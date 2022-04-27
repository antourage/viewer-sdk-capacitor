package com.antourage.plugin;

import android.app.Activity;
import android.graphics.Color;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import androidx.activity.ComponentActivity;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.lifecycle.Lifecycle;

import com.antourage.weaverlib.other.models.RegisterPushNotificationsResult;
import com.antourage.weaverlib.ui.AntourageFab;
import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

@NativePlugin(name = "Antourage")
public class AntourageCapacitor extends Plugin {
    private static AntourageFab antFab;
    private Lifecycle currentLifecycle;
    private int bottomMargin;
    private static final int MAX_BOTTOM_MARGIN = 220;

    private synchronized static AntourageFab getView(Activity activity) {
        if (antFab == null) {
            antFab = new AntourageFab(activity);
        }
        return antFab;
    }

    @PluginMethod()
    public void configure(PluginCall call) {
        int teamId = call.getInt("teamId");
        String localization = call.getString("localization");
        AntourageFab.Companion.configure(getContext(), teamId, localization);
    }

    public void setLifecycle(Lifecycle lifecycle) {
        currentLifecycle = lifecycle;
        if (antFab != null) {
            antFab.setLifecycle(currentLifecycle);
        }
    }

    @PluginMethod()
    public void setPortalColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setPortalColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setCtaBackgroundColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setCtaBackgroundColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setCtaTextColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setCtaTextColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setLiveDotColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setLiveDotColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setTitleTextColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setTitleTextColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setTitleBackgroundColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setTitleBackgroundColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setNameTextColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setNameTextColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setNameBackgroundColor(PluginCall call) {
        String color = call.getString("color");
        if (color == null || color.isEmpty()) {
            call.reject("Must provide valid color");
            return;
        }
        this.getActivity().runOnUiThread(() -> {
            getView(getActivity()).setNameBackgroundColor(Color.parseColor(color));
        });
    }

    @PluginMethod()
    public void setBottomMargin(PluginCall call) {
        Integer margin = call.getInt("margin");
        if (call.getString("platform") == "ios" || margin == null) {
            return;
        }
        bottomMargin = margin;
        this.getActivity().runOnUiThread(() -> {
            CoordinatorLayout.LayoutParams params = new CoordinatorLayout.LayoutParams(
                    FrameLayout.LayoutParams.WRAP_CONTENT,
                    FrameLayout.LayoutParams.WRAP_CONTENT);
            params.gravity = Gravity.BOTTOM | Gravity.END;
            params.setMargins(0, 0, 0, validateBottomMargin(bottomMargin));
            if (currentLifecycle != null) antFab.setLifecycle(currentLifecycle);
            getView(getActivity()).setLayoutParams(params);
        });
    }

    @PluginMethod()
    public void registerNotifications(PluginCall call) {
        String fcmToken = call.getString("fcmToken");

        if (fcmToken == null || fcmToken.isEmpty()) {
            call.reject("Must provide an fcmToken");
            return;
        }

        AntourageFab.Companion.registerNotifications(fcmToken,  result -> {
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
        this.getActivity().runOnUiThread(() -> {
            ComponentActivity activity = getActivity();
            if (antFab == null) {
                antFab = new AntourageFab(activity);
            }
            if (antFab.getParent() == null) {
                ViewGroup viewGroup = (ViewGroup) ((ViewGroup) activity.findViewById(android.R.id.content)).getChildAt(0);
                CoordinatorLayout.LayoutParams params = new CoordinatorLayout.LayoutParams(
                        FrameLayout.LayoutParams.WRAP_CONTENT,
                        FrameLayout.LayoutParams.WRAP_CONTENT);
                params.gravity = Gravity.BOTTOM | Gravity.END;
                params.setMargins(0, 0, 0, validateBottomMargin(bottomMargin));
                if (currentLifecycle != null) antFab.setLifecycle(currentLifecycle);
                viewGroup.addView(antFab, params);
            }
        });
    }

    @PluginMethod()
    public void hideWidget(PluginCall call) {
        this.getActivity().runOnUiThread(() -> {
            Activity activity = getActivity();
            ViewGroup viewGroup = (ViewGroup) ((ViewGroup) activity.findViewById(android.R.id.content)).getChildAt(0);
            viewGroup.removeView(antFab);
        });
    }

    private int validateBottomMargin(int marginInDp){
        if(marginInDp < 0){
            return 0;
        }else if(marginInDp > MAX_BOTTOM_MARGIN){
            return dp2px(MAX_BOTTOM_MARGIN);
        }else{
            return dp2px(marginInDp);
        }
    }


    public int dp2px(final int dp) {
        if(getContext() == null) return 0;
        return (int) (dp * getContext().getResources().getDisplayMetrics().density);
    }
}
