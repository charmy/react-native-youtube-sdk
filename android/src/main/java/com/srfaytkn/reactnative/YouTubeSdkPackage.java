package com.srfaytkn.reactnative;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;
import java.util.Collections;
import java.util.List;
import javax.annotation.Nonnull;

public class YouTubeSdkPackage implements ReactPackage {

  @Override
  public List<NativeModule> createNativeModules(@Nonnull ReactApplicationContext reactContext) {
    return Collections.singletonList(new YouTubeSdkModule(reactContext));
  }

  @Override
  public List<ViewManager> createViewManagers(@Nonnull ReactApplicationContext reactContext) {
    return Collections.singletonList(
        new YouTubeViewManager()
    );
  }
}