package com.srfaytkn.reactnative;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import java.util.Map;
import javax.annotation.Nonnull;
import javax.annotation.Nullable;

public class YouTubeViewManager extends SimpleViewManager<YouTubeView> {

  private static final String REACT_CLASS = "YouTubeView";
  private static final int COMMAND_SEEK_TO = 1;
  private static final int COMMAND_PLAY = 2;
  private static final int COMMAND_PAUSE = 3;

  @Nonnull
  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Nonnull
  @Override
  protected YouTubeView createViewInstance(@Nonnull ThemedReactContext reactContext) {
    return new YouTubeView(reactContext);
  }

  @Override
  public void receiveCommand(@Nonnull YouTubeView view, int commandId,
      @Nullable ReadableArray args) {
    switch (commandId) {
      case COMMAND_SEEK_TO:
        view.seekTo(args.getInt(0));
        break;
      case COMMAND_PLAY:
        view.play();
        break;
      case COMMAND_PAUSE:
        view.pause();
        break;
      default:
        throw new IllegalArgumentException(String.format(
            "Unsupported command %d received by %s.",
            commandId,
            getClass().getSimpleName()));
    }
  }

  @Nullable
  @Override
  public Map<String, Integer> getCommandsMap() {
    return MapBuilder.of(
        "seekTo", COMMAND_SEEK_TO,
        "play", COMMAND_PLAY,
        "pause", COMMAND_PAUSE
    );
  }

  @Nullable
  @Override
  public Map<String, Object> getExportedCustomDirectEventTypeConstants() {
    return MapBuilder.of(
        "onError", MapBuilder.of("registrationName", "onError"),
        "onChangeState", MapBuilder.of("registrationName", "onChangeState"),
        "onChangeFullscreen", MapBuilder.of("registrationName", "onChangeFullscreen")
    );
  }

  @ReactProp(name = "videoId")
  public void setPropVideoId(YouTubeView view, @Nullable String videoId) {
    view.getYouTubePlayerProps().setVideoId(videoId);
  }

  @ReactProp(name = "autoPlay")
  public void setPropAutoPlay(YouTubeView view, boolean autoPlay) {
    view.getYouTubePlayerProps().setAutoPlay(autoPlay);
  }

  @ReactProp(name = "fullscreen")
  public void setPropFullscreen(YouTubeView view, boolean fullscreen) {
    view.getYouTubePlayerProps().setFullscreen(fullscreen);
  }

  @ReactProp(name = "startTime")
  public void setPropStartTime(YouTubeView view, float startTime) {
    view.getYouTubePlayerProps().setStartTime(startTime);
  }

  @ReactProp(name = "showFullScreenButton")
  public void setPropShowFullScreenButton(YouTubeView view, boolean showFullScreenButton) {
    view.getYouTubePlayerProps().setShowFullScreenButton(showFullScreenButton);
  }

  @ReactProp(name = "showSeekBar")
  public void setPropShowSeekBar(YouTubeView view, boolean showSeekBar) {
    view.getYouTubePlayerProps().setShowSeekBar(showSeekBar);
  }

  @ReactProp(name = "showPlayPauseButton")
  public void setPropShowPlayPauseButton(YouTubeView view, boolean showPlayPauseButton) {
    view.getYouTubePlayerProps().setShowPlayPauseButton(showPlayPauseButton);
  }
}

