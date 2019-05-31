//
//  YouTubeView.swift
//  YouTubeSdk
//
//  Created by Buğra Göçer on 31.05.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//


import UIKit

class YouTubeView: UIView {
    
    @objc var onError: RCTDirectEventBlock?
    
    @objc var autoPlay: Bool = false;
    
    var playerVars:[String: Any] = [
        "controls" : "0",
        "showinfo" : "0",
        "autoplay": "0",
        "rel": "0",
        "modestbranding": "1",
        "iv_load_policy" : "3",
        "fs": "0",
        "ecver" : "2",
        "playsinline" : "1"
    ]
    
    @objc var fullscreen: Bool = false {
        didSet{
            playerVars["fs"] = (fullscreen) ? "1" : "0";
        }
    }
    
    @objc var showSeekBar: Bool = false {
        didSet{
            playerVars["controls"] = (showSeekBar) ? "1" : "0";
        }
    }
    
    @objc var videoId: NSString = "" {
        didSet{
            if videoId != ""{
                _ = player.load(videoId: videoId as String, playerVars: playerVars)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.player.isUserInteractionEnabled = false
        self.addSubview(player)
    }
    
    @objc func reactSetFrame(frame:CGRect) {
        super.reactSetFrame(frame)
        player.frame = frame
    }
    
    override func layoutSubviews() {
        player.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var player: YTPlayerView = {
        let playerView = YTPlayerView(frame: frame)
        playerView.delegate = self
        return playerView
    }()
    
    
    @objc func play() {
        if player.playerState != .playing{
            player.playVideo()
        }
    }
    
    @objc func pause() {
        if player.playerState == .playing{
            player.pauseVideo()
        }
    }
    
    @objc func seekTo(seconds: NSInteger) {
       player.seek(seekToSeconds: Float(seconds), allowSeekAhead: true)
    }
    
    @objc func LoadVideo(videoId: NSString, seconds: NSInteger) {
         _ = player.load(videoId: videoId as String,  playerVars: playerVars)
    }
}

extension YouTubeView: YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        if autoPlay{
            playerView.playVideo()
        }
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState){
        print(state)
    }
    
}
