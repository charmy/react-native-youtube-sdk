import React from "react";
import { NativeModules } from "react-native";
import YouTubePlayer from "./example/lib/YouTubePlayer";

const { YouTubeSdk } = NativeModules;

export { YouTubePlayer };
export default YouTubeSdk;
