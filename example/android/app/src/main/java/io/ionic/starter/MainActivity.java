package io.ionic.starter;

import android.os.Bundle;

import com.antourage.plugin.AntViewerPlugin;
import com.getcapacitor.BridgeActivity;
import com.getcapacitor.Plugin;

import java.util.ArrayList;

public class MainActivity extends BridgeActivity {
    private AntViewerPlugin antPlugin;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

//     Initializes the Bridge
        this.init(savedInstanceState, new ArrayList<Class<? extends Plugin>>() {{
            // Additional plugins you've installed go here
            add(AntViewerPlugin.class);
        }});
        antPlugin = (AntViewerPlugin) getBridge().getPlugin(AntViewerPlugin.class.getSimpleName()).getInstance();
    }

    @Override
    public void onPause() {
        super.onPause();
        antPlugin.onPause();
    }

    @Override
    public void onResume() {
        super.onResume();
        antPlugin.onResume();
    }
}
