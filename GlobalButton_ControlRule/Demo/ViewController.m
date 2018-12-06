//
//  ViewController.m
//  Demo
//
//  Created by EDZ on 2018/12/6.
//  Copyright © 2018年 fqy. All rights reserved.
//

#import "ViewController.h"

#import "UIViewController+DDPopUpViewController.h"

#import "UIViewController+FQY_Addition.h"

#import "GlobalView+StatusControl.h"

#import "ViewControllerFirst.h"
#import "ViewControllerSecond.h"
#import "ViewControllerThird.h"

#import "ViewControllerFour.h"

#import "FixedPopUpVC.h"

@interface ViewController ()

@property(nonatomic,strong)FixedPopUpVC *popUpVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 默认是非全局显示，设置显示的白名单，可以在这些页面显示了
    [GlobalView yd_setWhitelist:@[@"ViewController",@"ViewControllerFirst",@"ViewControllerThird"]];
    
    
}

- (IBAction)presentClick:(id)sender {
    
    ViewControllerFour *four = [ViewControllerFour new];
    four.title = @"four";
    [self presentViewController:four animated:YES completion:nil];
    
}


- (IBAction)goFirstClick:(id)sender {
    ViewControllerFirst *vc = [ViewControllerFirst new];
    vc.title = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goSecondVC:(id)sender {
    ViewControllerSecond *vc = [ViewControllerSecond new];
    vc.title = @"2";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goThirdVC:(id)sender {
    ViewControllerThird *vc = [ViewControllerThird new];
    vc.title = @"3";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)popUpFixedSizeVCClick:(id)sender {
    
    FixedPopUpVC *vc = [FixedPopUpVC new];
    vc.view.backgroundColor = [UIColor redColor];
    vc.popUpViewSize = CGSizeMake(100, 100);
    vc.popUpPosition = DDPopUpPositionCenter;
    
    /*
     *  对于 UIViewController+DDPopUpViewController 这种 通过 keyWindow 切换 show VC 的方式，
     
        self 的 viewwillappear 生命周期不会走，
     
        但是当前 VC 需要显示，所以再调用一次 show ,且在动画结束回调中。
     
    *   DDPopUpVC 动画结束后 [[UIApplication sharedApplication] keyWindow] 已切换为 self 所在window，
     
        [GlobalView show] 也是通过添加到 keywindow 的方式显示。
     
    *   DDPopUpViewController 源码也做了修改，遇到这类，可以看回调情况
     
    */
    
    // 动画结束前
//    vc.dismissCallback = ^{
//        [GlobalView show];
//    };
    
    // 动画结束后
    vc.dismissCompletionCallback = ^{
        [GlobalView show];
    };

    [self showPopUpViewController:vc animationType:DDPopUpAnimationTypeFade];
}

@end
