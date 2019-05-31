//
//  YoutubeViewManager.m
//  YouTubeSdk
//
//  Created by Buğra Göçer on 31.05.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "React/RCTViewManager.h"
#import "React/UIView+React.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_REMAP_MODULE(YouTubeView,YouTubeViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(autoPlay, BOOL)
RCT_EXPORT_VIEW_PROPERTY(showSeekBar, BOOL)
RCT_EXPORT_VIEW_PROPERTY(fullscreen, BOOL)
RCT_EXPORT_VIEW_PROPERTY(videoId, NSString)

RCT_EXPORT_VIEW_PROPERTY(onError, RCTDirectEventBlock)

RCT_EXTERN_METHOD(play:(nonnull NSNumber *)node)
RCT_EXTERN_METHOD(pause:(nonnull NSNumber *)node)

RCT_EXTERN_METHOD(seekTo:(nonnull NSNumber *)node
                  seconds:(nonnull NSInteger *)seconds)

RCT_EXTERN_METHOD(loadVideo:(nonnull NSNumber *)node
                  videoId:(nonnull NSString *)videoId
                  seconds:(nonnull NSInteger *)seconds)

@end


@interface RCT_EXTERN_MODULE(YouTubeSdk, NSObject)


@end
