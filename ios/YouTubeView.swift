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
    
    @objc var videoId: NSString = "" {
        didSet{
            if videoId != "" {
               //TODO
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(player)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var player: UIView = {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.red
        return view
    }()
    
    
    @objc func play() {
        print("play event");
    }
    
    @objc func reactSetFrame(frame:CGRect) {
        super.reactSetFrame(frame)
        player.frame = frame
    }
    
    override func layoutSubviews() {
        player.frame = self.bounds
    }
}
