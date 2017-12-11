//
//  LRGlowViewController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/8.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRGlowViewController.h"
#import "GCDTimer.h"

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
    //颜色分配
    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor whiteColor].CGColor,
                          (__bridge id)[UIColor redColor].CGColor];
    colorLayer.locations = @[@(-2),@(-1),@(0)];
    //开始点
    colorLayer.startPoint = CGPointMake(0, 0);
    //结束点
    colorLayer.endPoint = CGPointMake(1, 0);
    
    //绘制一个圆
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *bezierpath = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:80 startAngle:DEGRESS(0) endAngle:DEGRESS(360) clockwise:YES];
    circle.path = bezierpath.CGPath;
    circle.position = CGPointMake(100, 100);
    // 设置填充颜色为透明
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor redColor].CGColor;
    circle.lineWidth = 2;
    //circle.lineDashPattern = @[@1,@5,@1,@5];
    circle.strokeEnd = 1.0f;
    colorLayer.mask = circle;
    
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [_timer event:^{
        
        CABasicAnimation *faceAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
        faceAnim.fromValue = @[@(-0.2),@(-0.1),@(0)];
        faceAnim.toValue = @[@(1),@(1.1),@(1.2)];
        faceAnim.duration = 1.5;
        [colorLayer addAnimation:faceAnim forKey:nil];
        
    } timeInterval:2*NSEC_PER_SEC];
    
    [_timer start];
}



@end
