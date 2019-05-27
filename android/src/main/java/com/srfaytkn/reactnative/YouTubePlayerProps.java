package com.srfaytkn.reactnative;

import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.utils.YouTubePlayerTracker;

public class YouTubePlayerProps {

  private YouTubePlayerTracker tracker;
  private String videoId;
  private boolean autoPlay;
  private boolean fullscreen;
  private float startTime;
  private boolean showFullScreenButton;
  private boolean showSeekBar;
  private boolean showPlayPauseButton;

  public YouTubePlayerProps() {
    this.tracker = new YouTubePlayerTracker();
  }

  public YouTubePlayerTracker getTracker() {
    return tracker;
  }

  public String getVideoId() {
    return videoId;
  }

  public void setVideoId(String videoId) {
    this.videoId = videoId;
  }

  public boolean isAutoPlay() {
    return autoPlay;
  }

  public void setAutoPlay(boolean autoPlay) {
    this.autoPlay = autoPlay;
  }

  public boolean isFullscreen() {
    return fullscreen;
  }

  public void setFullscreen(boolean fullscreen) {
    this.fullscreen = fullscreen;
  }

  public float getStartTime() {
    return startTime;
  }

  public void setStartTime(float startTime) {
    this.startTime = startTime;
  }

  public boolean isShowFullScreenButton() {
    return showFullScreenButton;
  }

  public void setShowFullScreenButton(boolean showFullScreenButton) {
    this.showFullScreenButton = showFullScreenButton;
  }

  public boolean isShowSeekBar() {
    return showSeekBar;
  }

  public void setShowSeekBar(boolean showSeekBar) {
    this.showSeekBar = showSeekBar;
  }

  public boolean isShowPlayPauseButton() {
    return showPlayPauseButton;
  }

  public void setShowPlayPauseButton(boolean showPlayPauseButton) {
    this.showPlayPauseButton = showPlayPauseButton;
  }
}
