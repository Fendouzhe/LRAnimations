//
//  LRElectrocardiogramController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/11.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRElectrocardiogramController.h"
#import "UIView+SetRect.h"

#define LayerFrame CGRectMake(0,0,600,300);
#define LineWidth 3.0f;
#define ShadowOpacity 1.0f
#define ShadowRadius 4.0f

@interface LRElectrocardiogramController ()

@end

@implementation LRElectrocardiogramController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 界面缩小系数
    CGFloat scale = 1;
    
    if (iPhone4_4s || iPhone5_5s) {
        
        scale = 0.65f;
        
    } else if (iPhone6_6s || iPhoneX_X) {
        
        scale = 0.75f;
        
    } else if (iPhone6_6sPlus) {
        
        scale = 0.8f;
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    //绘制心电图背景
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = LayerFrame;
        shapeLayer.path = [self path].CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineWidth = 2.f;
        shapeLayer.opacity = 0.5;
        shapeLayer.position = self.view.center;
        shapeLayer.transform = CATransform3DMakeScale(scale, scale, 1.0f);
        [self.view.layer addSublayer:shapeLayer];
    }
    
    //redColor line
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = LayerFrame;
        shapeLayer.position = self.view.center;
        shapeLayer.path = [self path].CGPath;
        //一开始不展示
        shapeLayer.strokeEnd = 0.f;
        shapeLayer.lineWidth = LineWidth;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.shadowColor = [UIColor redColor].CGColor;
        shapeLayer.shadowRadius = ShadowRadius;
        shapeLayer.shadowOpacity = ShadowOpacity;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.transform = CATransform3DMakeScale(scale, scale, 1.0f);
        [self.view.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;//总进度的0.98
        CGFloat GAP = 0.02;//总进度的0.02
        //开始位置
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue = @(0);
        aniStart.toValue = @(MAX);
        //结束位置
        CABasicAnimation *aniEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue = @(GAP);
        aniEnd.toValue = @(MAX+GAP);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 4.f;
        group.repeatCount = MAXFLOAT;
        group.autoreverses = YES;
        group.animations = @[aniStart,aniEnd];
        
        [shapeLayer addAnimation:group forKey:nil];
        
    }
    
    //greenColor line
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = LayerFrame;
        shapeLayer.position = self.view.center;
        shapeLayer.path = [self path].CGPath;
        shapeLayer.strokeEnd = 0.f;
        shapeLayer.lineWidth = LineWidth;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor greenColor].CGColor;
        shapeLayer.shadowColor = [UIColor greenColor].CGColor;
        shapeLayer.shadowRadius = ShadowRadius;
        shapeLayer.shadowOpacity = ShadowOpacity;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.transform = CATransform3DMakeScale(scale, scale, 1.0f);
        [self.view.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;//总进度的0.98
        CGFloat GAP = 0.02;//总进度的0.02
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue = @0;
        aniStart.toValue = @(MAX);
        
        CABasicAnimation *aniEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue = @(GAP);
        aniEnd.toValue = @(GAP+MAX);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 8.f;
        group.repeatCount = MAXFLOAT;
        group.autoreverses = YES;
        group.animations = @[aniStart,aniEnd];
        [shapeLayer addAnimation:group forKey:nil];
        
    }
    
    //yellowColor line
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = LayerFrame;
        shapeLayer.position = self.view.center;
        shapeLayer.path = [self path].CGPath;
        shapeLayer.strokeEnd = 0.f;
        shapeLayer.lineWidth = LineWidth;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
        shapeLayer.shadowColor = [UIColor yellowColor].CGColor;
        shapeLayer.shadowRadius = ShadowRadius;
        shapeLayer.shadowOpacity = ShadowOpacity;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.transform = CATransform3DMakeScale(scale, scale, 1.0f);
        [self.view.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;//总进度的0.98
        CGFloat GAP = 0.02;//总进度的0.02
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue = @(MAX);
        aniStart.toValue = @(0);
        
        CABasicAnimation *aniEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue = @(GAP+MAX);
        aniEnd.toValue = @(GAP);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 8.f;
        group.repeatCount = MAXFLOAT;
        group.autoreverses = YES;
        group.animations = @[aniStart,aniEnd];
        [shapeLayer addAnimation:group forKey:nil];
        
    }
    
    //cyanColor line
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = LayerFrame;
        shapeLayer.position = self.view.center;
        shapeLayer.path = [self path].CGPath;
        shapeLayer.strokeEnd = 0.f;
        shapeLayer.lineWidth = LineWidth;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
        shapeLayer.shadowColor = [UIColor cyanColor].CGColor;
        shapeLayer.shadowRadius = ShadowRadius;
        shapeLayer.shadowOpacity = ShadowOpacity;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.transform = CATransform3DMakeScale(scale, scale, 1.0f);
        [self.view.layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;//总进度的0.98
        CGFloat GAP = 0.02;//总进度的0.02
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue = @(MAX);
        aniStart.toValue = @(0);
        
        CABasicAnimation *aniEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue = @(GAP+MAX);
        aniEnd.toValue = @(GAP);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 4.f;
        group.repeatCount = MAXFLOAT;
        group.autoreverses = YES;
        group.animations = @[aniStart,aniEnd];
        [shapeLayer addAnimation:group forKey:nil];
        
    }
    
}

- (UIBezierPath *)path {
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint   : CGPointMake(0, 150)];
    [bezierPath addLineToPoint: CGPointMake(68, 150)];
    [bezierPath addLineToPoint: CGPointMake(83, 107)];
    [bezierPath addLineToPoint: CGPointMake(96, 206)];
    [bezierPath addLineToPoint: CGPointMake(102, 150)];
    [bezierPath addLineToPoint: CGPointMake(116, 150)];
    [bezierPath addLineToPoint: CGPointMake(127, 82)];
    [bezierPath addLineToPoint: CGPointMake(143, 213)];
    [bezierPath addLineToPoint: CGPointMake(160, 150)];
    [bezierPath addLineToPoint: CGPointMake(179, 150)];
    [bezierPath addLineToPoint: CGPointMake(183, 135)];
    [bezierPath addLineToPoint: CGPointMake(192, 169)];
    [bezierPath addLineToPoint: CGPointMake(199, 150)];
    [bezierPath addLineToPoint: CGPointMake(210, 177)];
    [bezierPath addLineToPoint: CGPointMake(227, 70)];
    [bezierPath addLineToPoint: CGPointMake(230, 210)];
    [bezierPath addLineToPoint: CGPointMake(249, 135)];
    [bezierPath addLineToPoint: CGPointMake(257, 150)];
    [bezierPath addLineToPoint: CGPointMake(360, 150)];
    [bezierPath addLineToPoint: CGPointMake(372, 124)];
    [bezierPath addLineToPoint: CGPointMake(395, 197)];
    [bezierPath addLineToPoint: CGPointMake(408, 82)];
    [bezierPath addLineToPoint: CGPointMake(416, 150)];
    [bezierPath addLineToPoint: CGPointMake(424, 135)];
    [bezierPath addLineToPoint: CGPointMake(448, 224)];
    [bezierPath addLineToPoint: CGPointMake(456, 107)];
    [bezierPath addLineToPoint: CGPointMake(463, 150)];
    [bezierPath addLineToPoint: CGPointMake(600, 150)];
    return bezierPath;
}


@end
