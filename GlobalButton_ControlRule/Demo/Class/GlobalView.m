//
//  CustomView1.m
//  Demo
//
//  Created by EDZ on 2018/12/6.
//  Copyright © 2018年 fqy. All rights reserved.
//

#import "GlobalView.h"

@interface GlobalView ()
/** 按钮 */
@property (strong, nonatomic) UIButton *action;

@end

static GlobalView *shared_;

@implementation GlobalView

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared_ = [[self alloc] initWithFrame:CGRectMake(80, 200, 50, 50)];
    });
    return shared_;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _action = [[UIButton alloc] initWithFrame:self.bounds];
        _action.layer.cornerRadius = self.bounds.size.width * 0.5;
        _action.layer.masksToBounds = YES;
        _action.contentMode = UIViewContentModeScaleAspectFit;
        [_action setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:_action];
        [_action addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}


- (void)clickAction:(UIButton *)action {
    // 弹出功能
    
    NSLog(@"%s,弹出功能",__func__);
}

+ (void)hide {
    
    NSLog(@"%s",__func__);
    
    [GlobalView sharedInstance].hidden = YES;
}


+ (void)show {
    
    NSLog(@"%s",__func__);
    
    [GlobalView sharedInstance].hidden = NO;
    // 保证在最上层
    [[GlobalView sharedInstance] removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow addSubview:[GlobalView sharedInstance]];
}

#pragma mark ------------------LifeCycle------------------

#pragma mark ------------------Network------------------

#pragma mark ------------------Event------------------

#pragma mark ------------------Lazy------------------

@end
