//
//  LRShineLabelController.m
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/11.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRShineLabelController.h"
#import "LRShineLabel.h"

@interface LRShineLabelController ()

@end

@implementation LRShineLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    LRShineLabel *shine = [[LRShineLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    shine.center = self.view.center;
    shine.text = @"LeiLuRong";
    //初始大小系数
    shine.startScale = 0.3f;
    shine.endScale = 2.f;
    shine.backedLabelColor = [UIColor redColor];
    shine.colorLabelColor = [UIColor cyanColor];
    shine.font = [UIFont systemFontOfSize:30.f];
    [self.view addSubview:shine];
    
    [[GCDQueue mainQueue] execute:^{
        [shine startAnimation];
    }];
}

@end
