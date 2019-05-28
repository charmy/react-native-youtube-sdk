package com.srfaytkn.reactnative;

import android.annotation.SuppressLint;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import androidx.appcompat.app.AppCompatActivity;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.PlayerConstants.PlayerError;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.PlayerConstants.PlayerState;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.YouTubePlayer;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.listeners.AbstractYouTubePlayerListener;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.listeners.YouTubePlayerFullScreenListener;
import com.pierfrancescosoffritti.androidyoutubeplayer.core.player.views.YouTubePlayerView;
import javax.annotation.Nonnull;


@SuppressLint("ViewConstructor")
public class YouTubeView extends FrameLayout {

  public static final String TAG = YouTubeView.class.getSimpleName();

  private ReactContext context;
  private YouTubePlayerView youTubePlayerView;
  private YouTubePlayer youTubePlayer;
  private YouTubePlayerProps youTubePlayerProps;

  public YouTubeView(ReactContext context) {
    super(context);
    this.context = context;
    this.youTubePlayerProps = new YouTubePlayerProps();
    init();
  }

  private AppCompatActivity getCurrentActivity() {
    AppCompatActivity currentActivity = (AppCompatActivity) this.context.getCurrentActivity();
    if (currentActivity == null) {
      Log.e(TAG, "currentActivity is null");
      throw new YouTubeSdkException("currentActivity is null");
    }
    return currentActivity;
  }

  private void init() {
    View view = inflate(getContext(), R.layout.yt_view_layout, this);
    this.youTubePlayerView = view.findViewById(R.id.player);

    getCurrentActivity().getLifecycle().addObserver(youTubePlayerView);
    initYouTubePlayer();
  }

  @Override
  protected void onDetachedFromWindow() {
    youTubePlayerView.release();
    super.onDetachedFromWindow();
  }

  private void initYouTubePlayer() {
    youTubePlayerView.getPlayerUiController().showYouTubeButton(false);
    youTubePlayerView.getYouTubePlayerWhenReady(youTubePlayer -> {
      this.youTubePlayer = youTubePlayer;

      youTubePlayerView.getPlayerUiController()
          .showFullscreenButton(youTubePlayerProps.isShowFullScreenButton())
          .showSeekBar(youTubePlayerProps.isShowSeekBar())
          .showPlayPauseButton(youTubePlayerProps.isShowPlayPauseButton());

      youTubePlayer.loadVideo(youTubePlayerProps.getVideoId(), youTubePlayerProps.getStartTime());

      if (youTubePlayerProps.isAutoPlay()) {
        youTubePlayer.play();
      } else {
        youTubePlayer.pause();
      }

      if (youTubePlayerProps.isFullscreen()) {
        youTubePlayerView.enterFullScreen();
      }
      youTubePlayer.addListener(youTubePlayerProps.getTracker());
    });

    youTubePlayerView.addFullScreenListener(new YouTubePlayerFullScreenListener() {
      @Override
      public void onYouTubePlayerEnterFullScreen() {
        onChangeFullscreenEvent(true);
        youTubePlayer.pause();
        openFullscreenPlayer();
      }

      @Override
      public void onYouTubePlayerExitFullScreen() {
        onChangeFullscreenEvent(false);
        seekTo(youTubePlayerProps.getTracker().getCurrentSecond());

        if (youTubePlayerProps.getTracker().getVideoDuration() >
            youTubePlayerProps.getTracker().getCurrentSecond()) {
          play();
        }
      }
    });

    youTubePlayerView.addYouTubePlayerListener(new AbstractYouTubePlayerListener() {
      @Override
      public void onError(@Nonnull YouTubePlayer youTubePlayer, @Nonnull PlayerError error) {
        onErrorEvent(String.valueOf(error));
      }

      @Override
      public void onStateChange(@Nonnull YouTubePlayer youTubePlayer, @Nonnull PlayerState state) {
        onChangeStateEvent(String.valueOf(state));
      }
    });
  }

  public void onErrorEvent(String error) {
    WritableMap map = Arguments.createMap();
    map.putString("error", error);
    context.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onError", map);
  }

  public void onChangeStateEvent(String state) {
    WritableMap map = Arguments.createMap();
    map.putString("state", state);
    context.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onChangeState", map);
  }

  public void onChangeFullscreenEvent(boolean isFullscreen) {
    WritableMap map = Arguments.createMap();
    map.putBoolean("isFullscreen", isFullscreen);
    context.getJSModule(RCTEventEmitter.class).receiveEvent(getId(), "onChangeFullscreen", map);
  }

  public void seekTo(float time) {
    youTubePlayer.seekTo(time);
  }

  public void play() {
    youTubePlayer.play();
  }

  public void pause() {
    youTubePlayer.pause();
  }

  public YouTubePlayerProps getYouTubePlayerProps() {
    return youTubePlayerProps;
  }

  public void openFullscreenPlayer() {
    context.startActivity(FullscreenPlayerActivity.newIntent(getCurrentActivity(), this));
  }

  public void onCloseFullscreenPlayer(YouTubePlayerProps youTubePlayerProps) {
    this.youTubePlayerProps = youTubePlayerProps;
    youTubePlayerView.exitFullScreen();
  }
}
