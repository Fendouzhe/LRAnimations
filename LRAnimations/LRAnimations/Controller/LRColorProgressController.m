//
//  LRColorProgressController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/21.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRColorProgressController.h"
#import "LRColorFullProgressView.h"
#import "LRProgressColor.h"

@interface LRColorProgressController ()

@property (nonatomic, strong)GCDTimer *timer;

@property (nonatomic, strong)LRColorFullProgressView *progressView0;

@property (nonatomic, strong)LRColorFullProgressView *progressView1;

@end

@implementation LRColorProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    /*
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 80, 100, 200);
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.25,@0.5,@0.75];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
     */
    
    // progressView0
    self.progressView0 = [LRColorFullProgressView colorfulProgressViewWithFrame:CGRectMake(0, 160, self.view.width, 2.5)
                                                                  progressColor:nil];
    
    [self.view addSubview:self.progressView0];
    
    // progressView1
    self.progressView1 = [LRColorFullProgressView colorfulProgressViewWithFrame:CGRectMake(0, 180, self.view.width, 2.5)
                                                                  progressColor:[LRProgressColor redGradientColor]];
    
    [self.view addSubview:self.progressView1];
    
    // timer
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [_timer event:^{
        
        CGFloat percent0 = arc4random() % 101 / 100.f;
        CGFloat percent1 = arc4random() % 101 / 100.f;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:0 animations:^{
            _progressView0.progress = percent0;
            _progressView1.progress = percent1;
        } completion:^(BOOL finished) {
            
        }];
    } timeInterval:NSEC_PER_SEC];
    [_timer start];
}



@end
