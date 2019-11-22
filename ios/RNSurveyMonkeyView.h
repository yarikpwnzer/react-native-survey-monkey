#import <UIKit/UIKit.h>

@interface RNSurveyMonkeyView : UIView

@property (copy, nonatomic) NSString *survey;
@property (strong, nonatomic) NSDictionary *customVariables;
@property (copy, nonatomic) NSString *cancelButtonTintColor;

- (void)presentSurveyMonkeyViewController;

- (void)scheduleInterceptFromViewControllerWithTitle:(NSString *)title;

- (void)scheduleInterceptFromViewControllerWithParams:(NSDictionary *)params;

@end
  
