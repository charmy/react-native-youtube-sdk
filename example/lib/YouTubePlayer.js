import React from "react";
import ReactNative, { requireNativeComponent, NativeModules, UIManager } from "react-native";
import PropTypes from "prop-types";

const YouTubeView = requireNativeComponent("YouTubeView");
const { YouTubeSdk } = NativeModules;

export default class YouTubePlayer extends React.Component {
  seekTo(seconds) {
    if (!seconds) {
      throw new Error("missing parameter: seconds");
    }

    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.youTubeView),
      UIManager.YouTubeView.Commands.seekTo,
      [parseInt(seconds)],
    );
  }

  play() {
    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.youTubeView),
      UIManager.YouTubeView.Commands.play,
      [],
    );
  }

  pause() {
    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.youTubeView),
      UIManager.YouTubeView.Commands.pause,
      [],
    );
  }

  loadVideo(videoId = "", startTime = 0) {
    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.youTubeView),
      UIManager.YouTubeView.Commands.loadVideo,
      [String(videoId), parseInt(startTime)],
    );
  }

  getCurrentTime() {
    return new Promise((resolve, reject) =>
      YouTubeSdk.getCurrentTime(ReactNative.findNodeHandle(this.youTubeView))
        .then(currentTime => resolve(Math.round(currentTime)))
        .catch(errorMessage => reject(errorMessage)),
    );
  }

  getVideoDuration() {
    return new Promise((resolve, reject) =>
      YouTubeSdk.getVideoDuration(ReactNative.findNodeHandle(this.youTubeView))
        .then(duration => resolve(Math.round(duration)))
        .catch(errorMessage => reject(errorMessage)),
    );
  }

  render() {
    const { onReady, onError, onChangeState, onChangeFullscreen } = this.props;
    return (
      <YouTubeView
        ref={ref => (this.youTubeView = ref)}
        {...this.props}
        onReady={e => onReady && onReady(e.nativeEvent)}
        onError={e => onError && onError(e.nativeEvent)}
        onChangeState={e => onChangeState && onChangeState(e.nativeEvent)}
        onChangeFullscreen={e => onChangeFullscreen && onChangeFullscreen(e.nativeEvent)}
      />
    );
  }
}

YouTubePlayer.propTypes = {
  videoId: PropTypes.string.isRequired,
  autoPlay: PropTypes.bool,
  fullscreen: PropTypes.bool,
  startTime: PropTypes.number,
  showFullScreenButton: PropTypes.bool,
  showSeekBar: PropTypes.bool,
  showPlayPauseButton: PropTypes.bool,
  onReady: PropTypes.func,
  onError: PropTypes.func,
  onChangeState: PropTypes.func,
  onChangeFullscreen: PropTypes.func,
};

YouTubePlayer.defaultProps = {
  autoPlay: false,
  fullscreen: false,
  startTime: 0,
  showFullScreenButton: true,
  showSeekBar: true,
  showPlayPauseButton: true,
};
