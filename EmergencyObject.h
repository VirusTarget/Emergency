//
//  EmergencyObject.h
//  aaaaa
//
//  Created by 陈晋添 on 2018/2/28.
//  Copyright © 2018年 陈晋添. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface EmergencyObject : NSObject

@property (nonatomic, strong, readonly) NSDictionary<NSString *,NSURL *> *urlDict;

@property (nonatomic, strong, readonly) NSDictionary<NSString *,UIImage *> *picDict;


+ (EmergencyObject *)shareInstance;

+ (bool)isViewControllerInDict:(NSString *)className;
+ (void)addViewControllerWithDict:(NSDictionary *)classDict;
+ (void)addViewControllerWithClassName:(NSString *)className emergencyUrl:(NSURL *)url;
+ (void)addViewControllerWithClassName:(NSString *)className emergencyPicture:(UIImage *)image;
+ (void)removeViewControllerWithClassName:(NSString *)className;
+ (void)clear;
@end
