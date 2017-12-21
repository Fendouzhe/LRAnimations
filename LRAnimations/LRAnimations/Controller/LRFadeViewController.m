//
//  LRFadeViewController.m
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/11.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRFadeViewController.h"
#import "LRFadeView.h"

@interface LRFadeViewController ()

@property (nonatomic, strong) UILabel    *label;
@property (nonatomic, strong) LRFadeView *fadeView;

@property (nonatomic, strong)GCDTimer *timer;

@end

@implementation LRFadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
    _label.font = [UIFont systemFontOfSize:45.f];
    _label.center = self.view.center;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor grayColor];
    _label.text = @"LeiLuRong";
    [self.view addSubview:_label];
    
    self.fadeView = [[LRFadeView alloc] initWithFrame:_label.frame];
    _fadeView.text = _label.text;
    _fadeView.center = _label.center;
    [self.view addSubview:_fadeView];
    
    //[self performSelector:@selector(run) withObject:nil afterDelay:4.f];
    
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [_timer event:^{
        
        [self.fadeView fadeRight];
        
    } timeInterval:5*NSEC_PER_SEC];
    
    [_timer start];
}

- (void)run{
    [self.fadeView fadeRight];
}
@end
