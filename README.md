
# react-native-youtube-sdk

[![npm version](https://badge.fury.io/js/react-native-youtube-sdk.svg)](https://badge.fury.io/js/react-native-youtube-sdk)

## Progress

- [ ] ios
- [x] android (implemented 'com.pierfrancescosoffritti.androidyoutubeplayer')

## Note
- your android app needs to be using the androidx libraries instead of the old support libraries.

## Getting started

`$ npm install react-native-youtube-sdk --save`

### Mostly automatic installation

`$ react-native link react-native-youtube-sdk`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-youtube-sdk` and add `YouTubeSdk.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libYouTubeSdk.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.srfaytkn.reactnative.YouTubeSdkPackage;` to the imports at the top of the file
  - Add `new YouTubeSdkPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-youtube-sdk'
  	project(':react-native-youtube-sdk').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-youtube-sdk/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
    implementation project(':react-native-youtube-sdk')
  	```
## Usage

#### Example Component
````javascript
<YouTubePlayer
  ref={ref => (this.youTubePlayer = ref)}
  videoId="t_aIEOqB8VM"
  autoPlay={true}
  fullscreen={true}
  showFullScreenButton={true}
  showSeekBar={true}
  showPlayPauseButton={true}
  startTime={5}
  style={{ width: "100%", height: 200 }}
  onError={e => console.log(e)}
  onChangeState={e => console.log(e)}
  onChangeFullscreen={e => console.log(e)}
/>
````
#### Example Usage

```javascript
import React from "react";
import { ScrollView, StyleSheet, View, TouchableOpacity, Text, ToastAndroid } from "react-native";
import YouTubePlayer from "react-native-youtube-sdk";

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <ScrollView>
          <YouTubePlayer
            ref={ref => (this.youTubePlayer = ref)}
            videoId="t_aIEOqB8VM"
            autoPlay={true}
            fullscreen={false}
            showFullScreenButton={true}
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
            <TouchableOpacity style={styles.button} onPress={() => this.youTubePlayer.loadVideo("QdgRNIAdLi4", 0)}>
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
                ToastAndroid.show(String(currentTime), ToastAndroid.SHORT);
              }}
            >
              <Text style={{ color: "#ffffff" }}>getCurrentTime</Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.button}
              onPress={async () => {
                const duration = await this.youTubePlayer.getVideoDuration();
                ToastAndroid.show(String(duration), ToastAndroid.SHORT);
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
```
### API

##### Props

| Prop                 | Required | Type     | Default value | Description                                                                                    |
|----------------------|----------|----------|---------------|------------------------------------------------------------------------------------------------|
| videoId              | true     | string   |               | YouTube video id                                                                               |
| autoPlay             | false    | bool     | false         | Plays when player on ready                                                                     |
| fullscreen           | false    | bool     | false         | The video is play in fullscreen                                                                | 
| showFullScreenButton | false    | bool     | false         | Show or hide fullscreen button                                                                 |
| showSeekBar          | false    | bool     | true          | Show or hide seekbar                                                                           |
| showPlayPauseButton  | false    | bool     | true          | Show or hide play/pause button                                                                 |
| startTime            | false    | number   | 0             | start time of video for first play                                                             |
| onReady              | false    | func     |               | triggered when the player ready    
| onError              | false    | func     |               | triggered when error occurs                                                                    |
| onChangeState        | false    | func     |               | triggered when the state changes (UNKNOWN/UNSTARTED/ENDED/PLAYING/PAUSED/BUFFERING/VIDEO_CUED) |
| onChangeFullscreen   | false    | func     |               | triggered when the player enters or exits the fullscreen mode                                  |

##### Methods

| Name             | Params             | Return  | Descriptipon                                                           |
|------------------|--------------------|---------|------------------------------------------------------------------------|
| seekTo           | seconds            | void    | Seeks to a specified time in the video                                 |
| play             |                    | void    | play the video                                                         |
| pause            |                    | void    | pause the video                                                        |
| loadVideo        | videoId, startTime | void    | load a video to the player                                             |
| getCurrentTime   |                    | promise | Returns promise that results with the current time of the played video |
| getVideoDuration |                    | promise | Returns promise that results with the duration of the played video     |
 
