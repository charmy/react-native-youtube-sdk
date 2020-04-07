import React from "react";
import { ScrollView, StyleSheet, View, TouchableOpacity, Text, ToastAndroid , Alert} from "react-native";
import YouTubePlayer from "./lib/YouTubePlayer";

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <ScrollView>
          <YouTubePlayer
            ref={ref => (this.youTubePlayer = ref)}
            videoId="s0BZNbCZAUY"
            autoPlay={false}
            fullscreen={false}
            showFullScreenButton={false}
            showSeekBar={true}
            showPlayPauseButton={true}
            startTime={5}
            style={{ width: "100%", height: 200 }}
            onReady={e => console.log("onReady", e.type)}
            onError={e => console.log("onError", e.error)}
            onChangeState={e => console.log("onChangeState", e.state)}
            onChangeFullscreen={e => console.log("onChangeFullscreen", e.isFullscreen)}
          />
          <View>
            <TouchableOpacity style={styles.button} onPress={() => this.youTubePlayer.loadVideo("UXlRydNkByU", 0)}>
              <Text style={{ color: "#ffffff" }}>loadVideo</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.button} onPress={() => this.youTubePlayer.seekTo(10)}>
              <Text style={{ color: "#ffffff" }}>SeekTo(10)</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.button} onPress={() => this.youTubePlayer.play()}>
              <Text style={{ color: "#ffffff" }}>Play</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.button} onPress={() => this.youTubePlayer.pause()}>
              <Text style={{ color: "#ffffff" }}>Pause</Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.button}
              onPress={async () => {
                const currentTime = await this.youTubePlayer.getCurrentTime();
                Alert.alert(String(currentTime), String(currentTime))
              }}
            >
              <Text style={{ color: "#ffffff" }}>getCurrentTime</Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.button}
              onPress={async () => {
                const duration = await this.youTubePlayer.getVideoDuration();
               Alert.alert(String(duration), String(duration))
              }}
            >
              <Text style={{ color: "#ffffff" }}>getVideoDuration</Text>
            </TouchableOpacity>
          </View>
        </ScrollView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  button: {
    backgroundColor: "red",
    margin: 12,
    padding: 12,
    borderRadius: 4,
  },
});
