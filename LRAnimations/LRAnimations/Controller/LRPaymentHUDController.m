//
//  LRPaymentHUDController.m
//  LRAnimations
//
//  Created by 雷路荣 on 2018/12/28.
//  Copyright © 2018 LeiLuRong. All rights reserved.
//

#import "LRPaymentHUDController.h"
#import "LRPaymentLoadingHUD.h"
#import "LRPaymentSuccessHUD.h"


@interface LRPaymentHUDController ()

@end

@implementation LRPaymentHUDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始 " style:UIBarButtonItemStylePlain target:self action:@selector(showLoadingAnimation)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" 完成" style:UIBarButtonItemStylePlain target:self action:@selector(showSuccessAnimation)];
    
    self.navigationItem.rightBarButtonItems = @[rightBarButtonItem,leftBarButtonItem];
}

-(void)showLoadingAnimation{
    
    self.title = @"正在付款...";
    
    //隐藏支付完成动画
    [LRPaymentSuccessHUD hideInView:self.view];
    //显示支付中动画
    [LRPaymentLoadingHUD showInView:self.view];
}

-(void)showSuccessAnimation{
    
    self.title = @"付款完成";
    
    //隐藏支付中成动画
    [LRPaymentLoadingHUD hideInView:self.view];
    //显示支付完成动画
    [LRPaymentSuccessHUD showInView:self.view];
}



@end
