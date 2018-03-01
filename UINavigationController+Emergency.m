//
//  UINavigationController+Emergency.m
//  aaaaa
//
//  Created by 陈晋添 on 2018/2/28.
//  Copyright © 2018年 陈晋添. All rights reserved.
//

#import "UINavigationController+Emergency.h"
#import "objc/runtime.h"
#import "EmergencyObject.h"
#import "EmergencyViewController.h"

@implementation UINavigationController (Emergency)

+ (void)load {
    // 修改 push 方法
    Method normalPresent = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method emergencyPresent = class_getInstanceMethod([self class], @selector(emergencyPushViewController:animated:));
    method_exchangeImplementations(normalPresent, emergencyPresent);
}

- (void)emergencyPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSString *className = [NSString stringWithFormat:@"%@",[viewController class]];
    if ([EmergencyObject isViewControllerInDict:className]) {
        if ([[EmergencyObject shareInstance].urlDict.allKeys containsObject:className]) {
            viewController = [[EmergencyViewController alloc] initWithUrl:[EmergencyObject shareInstance].urlDict[className]];
        }
        else if ([[EmergencyObject shareInstance].picDict.allKeys containsObject:className]) {
            viewController = [[EmergencyViewController alloc] initWithPic:[EmergencyObject shareInstance].picDict[className]];
        }
    }
    [self emergencyPushViewController:viewController animated:animated];
    
}

@end
