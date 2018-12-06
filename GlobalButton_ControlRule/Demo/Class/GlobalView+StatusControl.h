//
//  CustomView1+StatusControl.h
//  Demo
//
//  Created by EDZ on 2018/12/6.
//  Copyright © 2018年 fqy. All rights reserved.
//

#import "GlobalView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalView (StatusControl)


/// 局部使用该库,默认局部使用
+ (void)yd_local;

/// 广泛使用该库       default 暂时是默认， yd_local 完成后，yd_local就会变成默认
+ (void)yd_widely;

/// 局部使用该库时，设置需要用到的控制器
+ (void)yd_setWhitelist:(NSArray<NSString *> *)list;

/// 广泛使用该库时，设置需要屏蔽的控制器
+ (void)yd_setBlacklist:(NSArray<NSString *> *)list;

+ (BOOL)needUpdateShowState:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
