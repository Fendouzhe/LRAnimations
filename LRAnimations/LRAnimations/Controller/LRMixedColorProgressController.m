//
//  LRMixedColorProgressController.m
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/8.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRMixedColorProgressController.h"

@interface LRMixedColorProgressController ()

@property (nonatomic, strong)UIView *upView;

@property (nonatomic, strong)UILabel *upLabel;

@property (nonatomic, strong)UIView *downView;

@property (nonatomic, strong)UILabel *downLabel;

@property (nonatomic, strong)GCDTimer *timer;

@end

@implementation LRMixedColorProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     给upView的frame值做动画才是label能够混色显示的核心
     
     upView(红色背景)   ===>  upLabel(白色底字)
     |                       |
     |                       |
     |                       |
     |                       |
     downView(白色背景) ===> downLabel(红色底字)
     
     */
    /*
    _downView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 22)];
    _downView.center = self.view.center;
    [self.view addSubview:_downView];
    _downView.layer.cornerRadius = 2;
    _downView.layer.masksToBounds = YES;
    _downView.layer.borderColor = [UIColor redColor].CGColor;
    _downView.layer.borderWidth = 0.5f;
    _downView.backgroundColor = [UIColor whiteColor];
    
    _downLabel = [[UILabel alloc] initWithFrame:_downView.bounds];
    [_downView addSubview:_downLabel];
    _downLabel.textAlignment = NSTextAlignmentCenter;
    _downLabel.text = @"LeiLuRong - iOS Programmer";
    _downLabel.font = [UIFont systemFontOfSize:14];
    _downLabel.textColor = [UIColor redColor];
    
    _upView = [[UIView alloc] initWithFrame:_downView.bounds];
    _upView.center = self.view.center;
    [self.view addSubview:_upView];
    _upView.layer.cornerRadius = 2;
    _upView.layer.masksToBounds = YES;
    _upView.backgroundColor = [UIColor redColor];
    
    _upLabel = [[UILabel alloc] initWithFrame:_upView.bounds];
    [_upView addSubview:_upLabel];
    _upLabel.textAlignment = NSTextAlignmentCenter;
    _upLabel.text = _downLabel.text;
    _upLabel.font = _downLabel.font;
    _upLabel.textColor = [UIColor whiteColor];
    */
    
    _downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220*LayoutMath, 22*LayoutMath)];
    _downLabel.center = self.view.center;
    [self.view addSubview:_downLabel];
    _downLabel.textAlignment = NSTextAlignmentCenter;
    _downLabel.text = @"LeiLuRong - iOS Programmer";
    _downLabel.font = [UIFont systemFontOfSize:14*LayoutMath];
    _downLabel.textColor = [UIColor redColor];
    _downLabel.layer.cornerRadius = 3*LayoutMath;
    _downLabel.layer.masksToBounds = YES;
    _downLabel.layer.borderColor = [UIColor redColor].CGColor;
    _downLabel.layer.borderWidth = 1;
    
    
    
    _upView = [[UIView alloc] initWithFrame:_downLabel.frame];
    [self.view addSubview:_upView];
    _upView.layer.cornerRadius = _downLabel.layer.cornerRadius;
    _upView.layer.masksToBounds = YES;
    _upView.backgroundColor = [UIColor redColor];
    
    _upLabel = [[UILabel alloc] initWithFrame:_upView.bounds];
    [_upView addSubview:_upLabel];
    _upLabel.textAlignment = NSTextAlignmentCenter;
    _upLabel.text = _downLabel.text;
    _upLabel.font = _downLabel.font;
    _upLabel.textColor = [UIColor whiteColor];
    
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    __weak typeof(self) weakSelf = self;
    [_timer event:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:3.f initialSpringVelocity:0 options:0 animations:^{
            
            strongSelf.upView.width = arc4random()%220*LayoutMath;
            
        } completion:^(BOOL finished) {
            
        }];
    } timeInterval:NSEC_PER_SEC];
    [_timer start];
}



@end
