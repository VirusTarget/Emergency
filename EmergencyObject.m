//
//  EmergencyObject.m
//  aaaaa
//
//  Created by 陈晋添 on 2018/2/28.
//  Copyright © 2018年 陈晋添. All rights reserved.
//

#import "EmergencyObject.h"

@interface EmergencyObject()

@property (nonatomic, strong) NSDictionary *urlDict;

@property (nonatomic, strong) NSDictionary *picDict;

@end

@implementation EmergencyObject

static EmergencyObject *emergencyObjectInstance = nil;

+ (EmergencyObject *)shareInstance {
    if (!emergencyObjectInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!emergencyObjectInstance) {
                emergencyObjectInstance = [[EmergencyObject alloc] init];
            }
        });
    }
    
    return emergencyObjectInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!emergencyObjectInstance) {
            emergencyObjectInstance = [super allocWithZone:zone];
        }
    });
    return emergencyObjectInstance;
}

//MARK:- function
//MARK:- find
+ (bool)isViewControllerInDict:(NSString *)className {
    if ([[self shareInstance].urlDict.allKeys containsObject:className]) {
        return YES;
    }
    if ([[self shareInstance].picDict.allKeys containsObject:className]) {
        return YES;
    }
    return NO;
}

//MARK:- add/change
+ (void)addViewControllerWithDict:(NSDictionary *)classDict {
    
    [classDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSURL class]]) {
            [self addViewControllerWithClassName:key emergencyUrl:obj];
        }
        else if ([obj isKindOfClass:[UIImage class]]) {
            [self addViewControllerWithClassName:key emergencyUrl:obj];
        }
    }];
}

+ (void)addViewControllerWithClassName:(NSString *)className emergencyUrl:(NSURL *)url {
    [self removeViewControllerWithClassName:className];
    
    EmergencyObject *object = [self shareInstance];
    
    NSMutableDictionary *mutableDict = [object.urlDict mutableCopy];
    
    mutableDict[className] = url;
    
    object.urlDict = [mutableDict copy];
}

+ (void)addViewControllerWithClassName:(NSString *)className emergencyPicture:(UIImage *)image {
    [self removeViewControllerWithClassName:className];
    
    EmergencyObject *object = [self shareInstance];
    
    NSMutableDictionary *mutableDict = [object.picDict mutableCopy];
    
    mutableDict[className] = image;
    
    object.picDict = [mutableDict copy];
}

//MARK:- remove
+ (void)removeViewControllerWithClassName:(NSString *)className {
    EmergencyObject *object = [self shareInstance];
    
    if ([object.urlDict.allKeys containsObject:className]) {
        NSMutableDictionary *mutableDict = [object.urlDict mutableCopy];
        [mutableDict removeObjectForKey:className];
        object.urlDict = mutableDict;
    }
    
    if ([object.picDict.allKeys containsObject:className]) {
        NSMutableDictionary *mutableDict = [object.picDict mutableCopy];
        [mutableDict removeObjectForKey:className];
        object.picDict = mutableDict;
    }
    
}

+ (void)clear {
    EmergencyObject *object = [self shareInstance];
    object.urlDict = [NSDictionary dictionary];
    object.picDict = [NSDictionary dictionary];
}

//MARK:- getter/setter
- (NSDictionary *)urlDict {
    if (!_urlDict) {
        _urlDict = [NSDictionary dictionary];
    }
    return _urlDict;
}

- (NSDictionary *)picDict {
    if (!_picDict) {
        _picDict = [NSDictionary dictionary];
    }
    return _picDict;
}
@end
