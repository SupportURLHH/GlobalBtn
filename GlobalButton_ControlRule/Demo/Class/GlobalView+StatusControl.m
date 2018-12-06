//
//  CustomView1+StatusControl.m
//  Demo
//
//  Created by EDZ on 2018/12/6.
//  Copyright © 2018年 fqy. All rights reserved.
//

#import "GlobalView+StatusControl.h"
#import <objc/runtime.h>

@implementation GlobalView (StatusControl)

static char kWRIsLocalUsedKey;
static char kWRWhiteistKey;
static char kWRBlacklistKey;

+ (BOOL)isLocalUsed {
    id isLocal = objc_getAssociatedObject(self, &kWRIsLocalUsedKey);
    return (isLocal != nil) ? [isLocal boolValue] : YES;
}

+ (void)yd_local {
    objc_setAssociatedObject(self, &kWRIsLocalUsedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)yd_widely {
    objc_setAssociatedObject(self, &kWRIsLocalUsedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray<NSString *> *)whitelist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kWRWhiteistKey);
    return (list != nil) ? list : nil;
}

+ (void)yd_setWhitelist:(NSArray<NSString *> *)list {
    NSAssert([self isLocalUsed], @"白名单是在设置 局部使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kWRWhiteistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray<NSString *> *)blacklist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kWRBlacklistKey);
    return (list != nil) ? list : nil;
}

+ (void)yd_setBlacklist:(NSArray<NSString *> *)list {
    NSAssert(list, @"list 不能设置为nil");
    NSAssert(![self isLocalUsed], @"黑名单是在设置 广泛使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kWRBlacklistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)needUpdateShowState:(UIViewController *)vc {
    NSString *vcStr = NSStringFromClass(vc.class);
    if ([self isLocalUsed]) {
        return [[self whitelist] containsObject:vcStr]; // 当白名单里 有 表示需要show
    } else {
        return ![[self blacklist] containsObject:vcStr];// 当黑名单里 没有 表示需要show
    }
}

@end
