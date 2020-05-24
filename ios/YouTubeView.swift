//
//  YouTubeView.swift
//  YouTubeSdk
//
//  Created by Bugra Ozgursoy on 31.05.2019.
//  Copyright © 2020 Bugra Ozgursoy. All rights reserved.
//


import UIKit
import YoutubePlayerView

@objc class YouTubeView: UIView {
    
    @objc var onError: RCTDirectEventBlock?
    @objc var onReady: RCTDirectEventBlock?
    @objc var onChangeState: RCTDirectEventBlock?
    @objc var onChangeFullscreen: RCTDirectEventBlock?
    
    @objc var autoPlay: Bool = false;
    
    var initialized = false;
    var lock = false;
    var playerVars:[String: Any] = [
        "controls" : "1",
        "showinfo" : "",
        "autoplay": "0",
        "rel": "0",
        "modestbranding": "1",
        "iv_load_policy" : "3",
        "fs": "0",
        "ecver" : "2",
        "playsinline" : "1",
        "origin": "https://youtube.com",
    ]
    
    @objc var fullscreen: Bool = false {
        didSet{
            playerVars["fs"] = (fullscreen) ? "1" : "0";
            playerVars["playsinline"] = (fullscreen) ? "0" : "1";
        }
    }
    
    @objc var showSeekBar: Bool = false {
        didSet{
            playerVars["controls"] = (showSeekBar) ? "1" : "0";
            self.player.isUserInteractionEnabled = showSeekBar
        }
    }
    
    @objc var showFullScreenButton: Bool = false {
        didSet{
            playerVars["fs"] = (showFullScreenButton) ? "1" : "0";
            playerVars["showinfo"] = (showFullScreenButton) ? "" : "0";
        }
    }
    
    @objc var videoId: NSString = "" {
        didSet {
            player.loadWithVideoId(videoId as String, with : playerVars)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(player)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidEnterFullscreen(_:)), name: UIWindow.didBecomeVisibleNotification, object: self.window)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidLeaveFullscreen(_:)), name: UIWindow.didBecomeHiddenNotification, object: self.window)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: UIWindow.didBecomeVisibleNotification, object: self.window)
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.didBecomeHiddenNotification, object: self.window)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func willResignActive(_ notification: Notification) {
        lock = true
        
        player.fetchPlayerState({ (state) in
            if state == .playing{
                self.player.pause()
            }
        })
    }
    
    @objc func appMovedToForeground() {
        lock = false;
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
    
    lazy var player: YoutubePlayerView = {
        let playerView = YoutubePlayerView(frame: frame)
        playerView.delegate = self
        return playerView
    }()
    
    
    @objc func play() {
        player.play()
    }
    
    @objc func pause() {
        if self.initialized {
            player.pause()
        }
    }
    
    @objc func seekTo(seconds: NSInteger) {
        player.seek(to: Float(seconds), allowSeekAhead: true)
    }
    
    @objc func LoadVideo(videoId: NSString, seconds: NSInteger) {
        player.loadWithVideoId(videoId as String, with : playerVars)
    }
    
    @objc func getCurrentTime(resolver resolve: @escaping RCTPromiseResolveBlock){
           self.player.fetchCurrentTime( { (time) in
            resolve(NSInteger(Int(time ?? 0)))
       })
    }

    @objc func getVideoDuration(resolver resolve: @escaping RCTPromiseResolveBlock){
           self.player.fetchDuration( { (time) in
            resolve(NSInteger(Int(time ?? 0)))
       })
    }
    
    @objc func onDidEnterFullscreen(_ notification: Notification) {
        if initialized{
            onChangeFullscreen!(["isFullscreen" : true])
        }
    }
    
    @objc func onDidLeaveFullscreen(_ notification: Notification) {
        if initialized{
            onChangeFullscreen!(["isFullscreen" : false])
        }
    }
}

extension YouTubeView: YoutubePlayerViewDelegate{
    
    func playerViewDidBecomeReady(_ playerView: YoutubePlayerView) {
        if autoPlay {
            playerView.play()
        }
    }
    
    func playerView(_ playerView: YoutubePlayerView, didChangedToState state: YoutubePlayerState){
        onChangeState!(
            ["state" :
                {
                    switch state {
                    case .unstarted:  return "UNSTARTED"
                    case .ended:  return "ENDED"
                    case .playing:
                        self.initialized = true;
                        if lock{
                            player.pause();
                        }
                        return "PLAYING"
                    case .paused:  return"PAUSED"
                    case .buffering:  return "BUFFERING"
                    case .queued:  return "QUEUED"
                    case .unknown:  return "UNKNOWN"
                    }
            }()
            ])
    }
    
    func playerView(_ playerView: YoutubePlayerView, receivedError error: Error) {
        onError!(["error" : error])
    }
    
}
