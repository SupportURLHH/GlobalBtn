//
//  UIViewController+FQY_Addition.m
//  Demo
//
//  Created by EDZ on 2018/12/6.
//  Copyright © 2018年 fqy. All rights reserved.
//

#import "UIViewController+FQY_Addition.h"
#import <objc/runtime.h>
#import "GlobalView+StatusControl.h"

@implementation UIViewController (FQY_Addition)
static char GlobalViewKey;

// custom navigationBar
- (UIView *)yd_globalView {
    UIView *globalView = objc_getAssociatedObject(self, &GlobalViewKey);
    return (globalView != nil) ? globalView : [GlobalView sharedInstance];
}

- (void)yd_globalView:(GlobalView *)globalView {
    objc_setAssociatedObject(self, &GlobalViewKey, globalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidAppear:),
            @selector(viewDidDisappear:)
        };
        
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"yd_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}


/**
 自定义规则限制内的 VC ，这里判断是 navigationController.viewControllers 和 直接 navigationController.viewControllers present 的VC
 @return 是否在规则限制内
 */
- (BOOL)canUpdateShowStatus {
    if (self.navigationController) {
        return [self.navigationController.viewControllers containsObject:self];
    }
    /*
     present 的VC,有特殊规则考虑的，或考虑不周的可以告诉我哈
     */
    return YES;
}

- (void)yd_viewWillAppear:(BOOL)animated {
    
    if ([self canUpdateShowStatus]) {
        if ([GlobalView needUpdateShowState:self]) {
            [GlobalView show];
        }else{
            [GlobalView hide];
        }
    }
    
    [self yd_viewWillAppear:animated];
}

- (void)yd_viewWillDisappear:(BOOL)animated {

    // 实现特殊需求逻辑，或此 demo 未考虑周全的bug
    
    [self yd_viewWillDisappear:animated];
}

- (void)yd_viewDidAppear:(BOOL)animated
{
    // 实现特殊需求逻辑，或此 demo 未考虑周全的bug
    
    [self yd_viewDidAppear:animated];
}

- (void)yd_viewDidDisappear:(BOOL)animated {
    
    // 实现特殊需求逻辑，或此 demo 未考虑周全的bug
    
    [self yd_viewDidDisappear:animated];
}

@end
