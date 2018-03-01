//
//  UIViewController+Emergency.m
//  aaaaa
//
//  Created by 陈晋添 on 2018/2/28.
//  Copyright © 2018年 陈晋添. All rights reserved.
//

#import "UIViewController+Emergency.h"
#import "objc/runtime.h"
#import "EmergencyObject.h"
#import "EmergencyViewController.h"

@implementation UIViewController (Emergency)

+ (void)load {
    // 修改 present 方法
    Method normalPresent = class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:));
    Method emergencyPresent = class_getInstanceMethod([self class], @selector(emergencyPresentViewController:animated:completion:));
    method_exchangeImplementations(normalPresent, emergencyPresent);
}

- (void)emergencyPresentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^)(void))completion {
    NSString *className = [NSString stringWithFormat:@"%@",[viewControllerToPresent class]];
    UIViewController *viewController = viewControllerToPresent;
    if ([EmergencyObject isViewControllerInDict:className]) {
        if ([[EmergencyObject shareInstance].urlDict.allKeys containsObject:className]) {
            viewController = [[EmergencyViewController alloc] initWithUrl:[EmergencyObject shareInstance].urlDict[className]];
        }
        else if ([[EmergencyObject shareInstance].picDict.allKeys containsObject:className]) {
            viewController = [[EmergencyViewController alloc] initWithPic:[EmergencyObject shareInstance].picDict[className]];
        }
    }
    [self emergencyPresentViewController:viewController animated:flag completion:completion];
}
@end
