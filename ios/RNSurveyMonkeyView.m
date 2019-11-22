
#import "RNSurveyMonkeyView.h"
#import <React/RCTComponent.h>
#import <SurveyMonkeyiOSSDK/SurveyMonkeyiOSSDK.h>

static NSDictionary *SurveyMonkeyErrorJson(NSError *error) {
  return @{
    @"code": @(error.code),
    @"description": error.userInfo[@"SurveyMonkeySDK_Error"],
    @"fullDescription": error.description
  };
}

static UIColor *colorFromHexString(NSString *hexString) {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@interface RNSurveyMonkeyView() <SMFeedbackDelegate>


@property (nonatomic, strong) SMFeedbackViewController *feedbackController;

@property (strong, nonatomic) UIViewController *parentViewController;

@property (copy, nonatomic) RCTBubblingEventBlock onRespondentDidEndSurvey;


@end

@implementation RNSurveyMonkeyView

#pragma mark - Public

- (void)presentSurveyMonkeyViewController {
  [self.feedbackController presentFromViewController:self.parentViewController
                                            animated:YES
                                          completion:nil];
}

- (void)scheduleInterceptFromViewControllerWithTitle:(NSString *)title {
    [self.feedbackController scheduleInterceptFromViewController:self.parentViewController
                                                    withAppTitle:title];
}

- (void)scheduleInterceptFromViewControllerWithParams:(NSDictionary *)params {
    [self.feedbackController scheduleInterceptFromViewController:self.parentViewController
                                                      alertTitle:params[@"title"]
                                                       alertBody:params[@"body"]
                                             positiveActionTitle:params[@"positiveActionTitle"]
                                                     cancelTitle:params[@"cancelTitle"]
                                            afterInstallInterval:[params[@"afterInstallInterval"] doubleValue]
                                             afterAcceptInterval:[params[@"afterAcceptInterval"] doubleValue]
                                            afterDeclineInterval:[params[@"afterDeclineInterval"] doubleValue]];
}

#pragma mark - Lazy

- (SMFeedbackViewController *)feedbackController {
  if (!_feedbackController) {
    if (self.customVariables) {
       _feedbackController = [[SMFeedbackViewController alloc] initWithSurvey:self.survey
                                                           andCustomVariables:self.customVariables];
     } else {
       _feedbackController = [[SMFeedbackViewController alloc] initWithSurvey:self.survey];
     }
     _feedbackController.delegate = self;
    if (self.cancelButtonTintColor) {
      _feedbackController.cancelButtonTintColor = colorFromHexString(self.cancelButtonTintColor);
    }
  }
  return _feedbackController;
}

- (UIViewController *)parentViewController {
  if (!_parentViewController) {
    UIResponder *parentResponder = self;
    while (parentResponder != nil) {
        parentResponder = parentResponder.nextResponder;
        if ([parentResponder isKindOfClass:[UIViewController class]]) {
          _parentViewController = (UIViewController *)parentResponder;
          return _parentViewController;
        }
    }
  }
  return _parentViewController;
}

#pragma mark - SMFeedbackDelegate

- (void)respondentDidEndSurvey:(SMRespondent *)respondent error:(NSError *) error {
  NSDictionary *payload = @{
    @"respondent": respondent ? respondent.toJson : [NSNull null],
    @"error": error ? SurveyMonkeyErrorJson(error) : [NSNull null]
  };
  self.onRespondentDidEndSurvey(payload);
}

@end
  
