package com.srfaytkn.reactnative;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.uimanager.IllegalViewOperationException;
import com.facebook.react.uimanager.UIManagerModule;

public class YouTubeSdkModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public YouTubeSdkModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "YouTubeSdk";
  }

  @ReactMethod
  public void getCurrentTime(final int reactTag, final Promise promise) {
    try {
      UIManagerModule uiManager = reactContext.getNativeModule(UIManagerModule.class);
      uiManager.addUIBlock(nvhm -> {
        YouTubeView youTubeView = (YouTubeView) nvhm.resolveView(reactTag);
        promise.resolve(youTubeView.getYouTubePlayerProps().getTracker().getCurrentSecond());
      });
    } catch (Exception e) {
      promise.reject("getCurrentTime", e);
    }
  }

  @ReactMethod
  public void getVideoDuration(final int reactTag, final Promise promise) {
    try {
      UIManagerModule uiManager = reactContext.getNativeModule(UIManagerModule.class);
      uiManager.addUIBlock(nvhm -> {
        YouTubeView youTubeView = (YouTubeView) nvhm.resolveView(reactTag);
        promise.resolve(youTubeView.getYouTubePlayerProps().getTracker().getVideoDuration());
      });
    } catch (IllegalViewOperationException e) {
      promise.reject("getVideoDuration", e);
    }
  }
}