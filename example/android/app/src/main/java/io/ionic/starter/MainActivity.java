package io.ionic.starter;

import android.os.Bundle;

import com.antourage.plugin.AntourageCapacitor;
import com.getcapacitor.BridgeActivity;
import com.getcapacitor.Plugin;

import java.util.ArrayList;

public class MainActivity extends BridgeActivity {
    private AntourageCapacitor antouragePlugin;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Initializes the Bridge
        this.init(savedInstanceState, new ArrayList<Class<? extends Plugin>>() {{
            // Additional plugins you've installed go here
            add(AntourageCapacitor.class);
        }});
        antouragePlugin = (AntourageCapacitor)getBridge()
                .getPlugin("Antourage")
                .getInstance();
    }

    @Override
    public void onPause() {
        super.onPause();
        antouragePlugin.onPause();
    }

    @Override
    public void onResume() {
        super.onResume();
        antouragePlugin.onResume();
    }
}
