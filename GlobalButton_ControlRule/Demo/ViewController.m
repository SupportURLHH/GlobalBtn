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
    vc.popUpViewSize = CGSizeMake(100, 100);
    vc.popUpPosition = DDPopUpPositionCenter;
    [self showPopUpViewController:vc animationType:DDPopUpAnimationTypeFade];
}

@end
