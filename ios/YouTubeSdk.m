//
//  YouTubeSdk.m
//  YouTubeSdk
//
//  Created by Buğra Göçer on 1.06.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "React/RCTViewManager.h"
#import "React/UIView+React.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_REMAP_MODULE(YouTubeSdk, YouTubeSdk, RCTViewManager)


RCT_EXTERN_METHOD(getCurrentTime:
                  (nonnull NSNumber *)node
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getVideoDuration:
                  (nonnull NSNumber *)node
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
