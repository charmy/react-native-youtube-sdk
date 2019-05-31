//
//  YouTubeSdk.swift
//  YouTubeSdk
//
//  Created by Buğra Göçer on 31.05.2019.
//  Copyright © 2019 Facebook. All rights reserved.
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
            
            resolve(component.getCurrentTime());
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
            
            resolve(component.getVideoDuration());
        }
    }
}
