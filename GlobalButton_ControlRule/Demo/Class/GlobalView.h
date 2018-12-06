//
//  CustomView1.h
//  Demo
//
//  Created by EDZ on 2018/12/6.
//  Copyright © 2018年 fqy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>
 */
@interface GlobalView : UIView


+ (instancetype)sharedInstance;

+ (void)show;
+ (void)hide;

@end

NS_ASSUME_NONNULL_END