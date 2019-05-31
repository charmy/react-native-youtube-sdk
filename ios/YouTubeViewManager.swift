//
//  YouTubeViewManager.swift
//  YouTubeSdk
//
//  Created by Buğra Göçer on 31.05.2019.
//  Copyright © 2019 Facebook. All rights reserved.
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
    
}
