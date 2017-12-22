//
//  LRColorImageViewController.m
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/22.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRColorImageViewController.h"
#import "LRColorUIImageView.h"

@interface LRColorImageViewController ()

@property (nonatomic, strong) LRColorUIImageView *colorView;

@end

@implementation LRColorImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorView        = [[LRColorUIImageView alloc] initWithFrame:self.view.bounds];
    self.colorView.center = self.view.center;
    self.colorView.image  = [UIImage imageNamed:@"bg"];
    [self.view addSubview:self.colorView];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(event) userInfo:nil repeats:YES];
}

- (void)event {
    self.colorView.direction = UP;
    self.colorView.color     = [UIColor cyanColor];
    self.colorView.percent   = arc4random()%100/100.f;//0.5;
}

@end
