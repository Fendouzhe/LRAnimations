//
//  LRUnlockAnimationController.m
//  LRAnimations
//
//  Created by 雷路荣 on 2018/1/1.
//  Copyright © 2018年 LeiLuRong. All rights reserved.
//

#import "LRUnlockAnimationController.h"

@interface LRUnlockAnimationController ()

@property (nonatomic, strong)UILabel *unlockLabel;

@end

@implementation LRUnlockAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    // gradientLayer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.width, 68);
    gradientLayer.position = self.view.center;
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                                (__bridge id)[UIColor whiteColor].CGColor,
                                (__bridge id)[UIColor blackColor].CGColor];
    gradientLayer.locations = @[@0.25,@0.5,@0.75];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [self.view.layer addSublayer:gradientLayer];
    
    // unlockLabel
    self.unlockLabel = [[UILabel alloc] initWithFrame:gradientLayer.bounds];
    _unlockLabel.textAlignment = NSTextAlignmentCenter;
    _unlockLabel.text = @"滑动来解锁 >>";
    _unlockLabel.font = [UIFont boldSystemFontOfSize:28];
    _unlockLabel.textColor = [UIColor colorWithWhite:0 alpha:0.8];
    gradientLayer.mask = _unlockLabel.layer;
    
    
    // animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@0,@0,@0.25];
    animation.toValue = @[@0.75,@1,@1];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 2.5f;
    [gradientLayer addAnimation:animation forKey:nil];
    
}



@end
