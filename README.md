
# react-native-youtube-sdk

## Getting started

`$ npm install react-native-youtube-sdk --save`

### Mostly automatic installation

`$ react-native link react-native-youtube-sdk`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-youtube-sdk` and add `YouTubeSdk.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libYouTubeSdk.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

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
```javascript
import YouTubeSdk from 'react-native-youtube-sdk';

// TODO: What to do with the module?
YouTubeSdk;
```
  