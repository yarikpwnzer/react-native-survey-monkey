//
//  RNSurveyMonkeyViewManager.m
//  Therapeer
//
//  Created by Фучко Ярослав on 20.11.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSurveyMonkeyViewManager.h"
#import <UIKit/UIKit.h>
#import "RNSurveyMonkeyView.h"

@implementation RNSurveyMonkeyViewManager

RCT_EXPORT_MODULE()

- (UIView *)view {
    return [[RNSurveyMonkeyView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(onRespondentDidEndSurvey, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(cancelButtonTintColor, NSString)

RCT_EXPORT_METHOD(presentSurveyMonkey:(nonnull NSNumber *)reactTag
                           surveyHash:(nonnull NSString *)surveyHash
                      customVariables:(NSDictionary *)customVariables
               scheduleInterceptTitle:(NSString *)scheduleInterceptTitle
              scheduleInterceptParams:(NSDictionary *)scheduleInterceptParams) {
  [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
    UIView *view = viewRegistry[reactTag];
    if (!view || ![view isKindOfClass:[RNSurveyMonkeyView class]]) {
      RCTLogError(@"Cannot find RNSurveyMonkeyView with tag #%@", reactTag);
      return;
    }
    RNSurveyMonkeyView *monkeyView = (RNSurveyMonkeyView *)view;
    monkeyView.survey = surveyHash;
    if (customVariables) {
      monkeyView.customVariables = customVariables;
    }
    if (scheduleInterceptTitle) {
      [monkeyView scheduleInterceptFromViewControllerWithTitle:scheduleInterceptTitle];
    } else if (scheduleInterceptParams) {
      [monkeyView scheduleInterceptFromViewControllerWithParams:scheduleInterceptParams];
    } else {
      [monkeyView presentSurveyMonkeyViewController];
    }
  }];
}

@end
