//
//  YouTubeViewManager.swift
//  YouTubeSdk
//
//  Created by Bugra Ozgursoy on 31.05.2019.
//  Copyright © 2020 Bugra Ozgursoy. All rights reserved.
//

@objc(YouTubeViewManager)
class YouTubeViewManager: RCTViewManager {
    
    override func view() -> UIView! {
        return YouTubeView()
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func play(_ node: NSNumber) {
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
                ) as! YouTubeView
            component.play()
        }
    }
    
    @objc func pause(_ node: NSNumber) {
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
                ) as! YouTubeView
            component.pause()
        }
    }
    
    @objc func seekTo(_ node: NSNumber, seconds:NSInteger) {
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
                ) as! YouTubeView
            component.seekTo(seconds: seconds)
        }
    }
    
    @objc func loadVideo(_ node: NSNumber, videoId:NSString, seconds:NSInteger) {
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
                ) as! YouTubeView
            component.LoadVideo(videoId: videoId, seconds: seconds)
        }
    }
    
}
