
#import "YouTubeSdk.h"

@implementation YouTubeSdk

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()
    
    
RCT_EXPORT_METHOD(getCurrentTime:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    NSInteger num = 8;
    
    NSArray *data = @[@1];
    resolve(data);
}
    
    

@end
  
