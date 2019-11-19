
#import "RNSurveyMonkey.h"

@interface RNSurveyMonkey() <SMFeedbackDelegate>

@property (assign, nonatomic) BOOL hasListeners;

@end

@implementation RNSurveyMonkey

#pragma mark - RCT

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initWithSurvey:(NSString *)survey)
{
    self.feedbackController = [[SMFeedbackViewController alloc] initWithSurvey:survey];
    self.feedbackController.delegate = self;
}

RCT_EXPORT_METHOD(initWithSurvey:(NSString *)survey andCustomVariables:(NSDictionary *)variables)
{
    self.feedbackController = [[SMFeedbackViewController alloc] initWithSurvey:survey andCustomVariables:variables];
    self.feedbackController.delegate = self;
}

RCT_EXPORT_METHOD(presentFeedback) {
    self.shouldPresent = YES;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"respondentDidEndSurvey", @"respondentDidEndSurveyWithError"];
}

- (void)startObserving {
    self.hasListeners = YES;
}

- (void)stopObserving {
    self.hasListeners = NO;
}

#pragma SMFeedbackDelegate

- (void)respondentDidEndSurvey:(SMRespondent *)respondent error:(NSError *) error {
    if (!self.hasListeners) {
        return;
    }
    if (!error) {
        [self sendEventWithName:@"respondentDidEndSurvey" body:respondent.toJson];
    } else {
        [self sendEventWithName:@"respondentDidEndSurveyWithError" body:error.userInfo];
    }
}

@end
  
