//
//  LRGlowViewController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/8.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRGlowViewController.h"

#define DEGRESS(degress) ((M_PI*(degress))/180.f)
@interface LRGlowViewController ()

@property (nonatomic, strong)GCDTimer *timer;

@end

@implementation LRGlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    colorLayer.frame = (CGRect){CGPointZero,CGSizeMake(200, 200)};
    colorLayer.position = self.view.center;
    [self.view.layer addSublayer:colorLayer];
    
    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor whiteColor].CGColor,
                          (__bridge id)[UIColor redColor].CGColor];
    colorLayer.locations = @[@(-2),@(-1),@(0)];
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(1, 0);
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *bezierpath = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:80 startAngle:DEGRESS(0) endAngle:DEGRESS(360) clockwise:YES];
}



@end
