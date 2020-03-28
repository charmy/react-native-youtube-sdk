//
//  YouTubeSdk.swift
//  YouTubeSdk
//
//  Created by Bugra Ozgursoy on 31.05.2019.
//  Copyright © 2020 Bugra Ozgursoy. All rights reserved.
//

@objc(YouTubeSdk)
class YouTubeSdk: RCTViewManager {
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func getCurrentTime(
        _ node: NSNumber,
        resolver resolve: @escaping RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
        ) -> Void {
        
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
                ) as! YouTubeView
            
            component.getCurrentTime(resolver: resolve);
        }
    }
    
    @objc func getVideoDuration(
        _ node: NSNumber,
        resolver resolve: @escaping RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
        ) -> Void {
        
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
                ) as! YouTubeView
            
            component.getVideoDuration(resolver: resolve);
        }
    }
}
