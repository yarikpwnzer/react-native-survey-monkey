
#import "RNSurveyMonkeyView.h"
#import "RNSurveyMonkey.h"

@interface RNSurveyMonkeyView()

@property (nonatomic, strong) RNSurveyMonkey *surveyMonkey;

@end

@implementation RNSurveyMonkeyView

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.surveyMonkey.shouldPresent) {
        return;
    }
    if (self.surveyMonkey.feedbackController) {
        [self embed];
    } else {
        self.surveyMonkey.feedbackController.view.frame = self.bounds;
    }
}

#pragma mark - Private

- (void)embed {
    UIViewController *parentVC = [self parentViewController];
    if (parentVC) {
        [parentVC addChildViewController:self.surveyMonkey.feedbackController];
        [self addSubview:self.surveyMonkey.feedbackController.view];
        self.surveyMonkey.feedbackController.view.frame = self.bounds;
        [self.surveyMonkey.feedbackController didMoveToParentViewController:parentVC];
    }
}

- (UIViewController *)parentViewController {
    UIResponder *parentResponder = self;
    while (parentResponder != nil) {
        parentResponder = parentResponder.nextResponder;
        if ([parentResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *viewController = (UIViewController *)parentResponder;
            return viewController;
        }
    }
    return nil;
}

#pragma mark - RCT

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

@end
  
