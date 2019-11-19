
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
#import <React/RCTEventEmitter.h>
#import <SurveyMonkeyiOSSDK/SurveyMonkeyiOSSDK.h>

@interface RNSurveyMonkey : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic, strong) SMFeedbackViewController *feedbackController;
@property (nonatomic, assign) BOOL shouldPresent;

@end
  
