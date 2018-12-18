//
//  LRYouKuPlayButton.m
//  XLPlayButtonExample
//
//  Created by 雷路荣 on 2018/12/18.
//  Copyright © 2018 mxl. All rights reserved.
//

#import "LRYouKuPlayButton.h"

static CGFloat animationDuration = 0.35f;
//线条颜色
#define BLueColor [UIColor colorWithRed:62/255.0 green:157/255.0 blue:254/255.0 alpha:1]
#define LightBLueColor [UIColor colorWithRed:87/255.0 green:188/255.0 blue:253/255.0 alpha:1]
#define RedColor [UIColor colorWithRed:228/255.0 green:35/255.0 blue:6/255.0 alpha:0.8]

@interface LRYouKuPlayButton(){
    
    //红色三角形容器
    CALayer *_triangleContainer;
    //左边竖线
    CAShapeLayer *_leftLine;
    //左边半圆弧
    CAShapeLayer *_leftCircle;
    //右边竖线
    CAShapeLayer *_rightLine;
    //右边半圆弧
    CAShapeLayer *_rightCircle;
    
    BOOL _isAnimationing;
    
}
@end

@implementation LRYouKuPlayButton

- (instancetype)initWithFrame:(CGRect)frame playState:(LRYouKuPlayButtonState)playState{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        if (playState == LRYouKuPlayButtonStatePlay) {
            self.playState = playState;
        }
    }
    return self;
}

- (void)buildUI{
    [self addLeftCircleLayer];
    [self addRightCircleLayer];
    [self addLeftLineLayer];
    [self addRightLineLayer];
    [self addCenterTriangleLayer];
}

- (void)addLeftCircleLayer{
    CGFloat width = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.2, width*0.9)];
    CGFloat startAngle = acos(4.0/5.0)+M_PI_2;
    CGFloat endAngle = startAngle-M_PI;
    [path addArcWithCenter:CGPointMake(width*0.5, width*0.5) radius:width*0.5 startAngle:startAngle endAngle:endAngle clockwise:NO];
    
    _leftCircle = [CAShapeLayer layer];
    _leftCircle.path = path.CGPath;
    _leftCircle.fillColor = [UIColor clearColor].CGColor;
    _leftCircle.strokeColor = LightBLueColor.CGColor;
    _leftCircle.lineWidth = [self lineWidth];
    _leftCircle.lineCap = kCALineJoinRound;
    _leftCircle.lineJoin = kCALineJoinRound;
    _leftCircle.strokeEnd = 0;
    [self.layer addSublayer:_leftCircle];
}

- (void)addRightCircleLayer{
    CGFloat width = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.8, width*0.1)];
    CGFloat startAngle = -asin(4.0/5.0);
    CGFloat endAngle = startAngle-M_PI;
    [path addArcWithCenter:CGPointMake(width*0.5, width*0.5) radius:width*0.5 startAngle:startAngle endAngle:endAngle clockwise:NO];
    
    _rightCircle = [CAShapeLayer layer];
    _rightCircle.path = path.CGPath;
    _rightCircle.fillColor = [UIColor clearColor].CGColor;
    _rightCircle.strokeColor = LightBLueColor.CGColor;
    _rightCircle.lineWidth = [self lineWidth];
    _rightCircle.lineCap = kCALineJoinRound;
    _rightCircle.lineJoin = kCALineJoinRound;
    _rightCircle.strokeEnd = 0;
    [self.layer addSublayer:_rightCircle];
}

- (void)addLeftLineLayer{
    CGFloat width = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.2, width*0.9)];
    [path addLineToPoint:CGPointMake(width*0.2, width*0.1)];
    
    _leftLine = [CAShapeLayer layer];
    _leftLine.path = path.CGPath;
    _leftLine.fillColor = [UIColor clearColor].CGColor;
    _leftLine.strokeColor = BLueColor.CGColor;
    _leftLine.lineWidth = [self lineWidth];
    _leftLine.lineJoin = kCALineJoinRound;
    _leftLine.lineCap = kCALineJoinRound;
    [self.layer addSublayer:_leftLine];
}

- (void)addRightLineLayer{
    CGFloat width = self.layer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.8, width*0.1)];
    [path addLineToPoint:CGPointMake(width*0.8, width*0.9)];
    
    _rightLine = [CAShapeLayer layer];
    _rightLine.path = path.CGPath;
    _rightLine.fillColor = [UIColor clearColor].CGColor;
    _rightLine.strokeColor = BLueColor.CGColor;
    _rightLine.lineWidth = [self lineWidth];
    _rightLine.lineCap = kCALineJoinRound;
    _rightLine.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLine];
}

- (void)addCenterTriangleLayer{
    CGFloat width = self.layer.bounds.size.width;
    CGFloat triangWidth = width*0.4;
    CGFloat triangHeight = width*0.35;
    
    _triangleContainer = [CALayer layer];
    _triangleContainer.bounds = CGRectMake(0, 0, triangWidth, triangHeight);
    _triangleContainer.position = CGPointMake(width*0.5, width*0.55);
    //_triangleContainer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:_triangleContainer];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 0)];
    [path1 addLineToPoint:CGPointMake(triangWidth*0.5, triangHeight)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(triangWidth, 0)];
    [path2 addLineToPoint:CGPointMake(triangWidth/2, triangHeight)];
    
    CAShapeLayer *line1 = [CAShapeLayer layer];
    line1.path = path1.CGPath;
    line1.fillColor = [UIColor clearColor].CGColor;
    line1.strokeColor = RedColor.CGColor;
    line1.lineWidth = [self lineWidth];
    line1.lineJoin = kCALineJoinRound;
    line1.lineCap = kCALineJoinRound;
    [_triangleContainer addSublayer:line1];
    
    CAShapeLayer *line2 = [CAShapeLayer layer];
    line2.path = path2.CGPath;
    line2.fillColor = [UIColor clearColor].CGColor;
    line2.strokeColor = RedColor.CGColor;
    line2.lineWidth = [self lineWidth];
    line2.lineJoin = kCALineJoinRound;
    line2.lineCap = kCALineJoinRound;
    _triangleContainer.opacity = 0;
    [_triangleContainer addSublayer:line2];
}

- (CGFloat)lineWidth{
    return self.layer.bounds.size.width*0.18;
}

#pragma mark -- 动画方法 --
/**
 strokeEnd动画
 */
- (CABasicAnimation *)strokeEndAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue layer:(CALayer *)layer duration:(CGFloat)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(fromValue);
    animation.toValue = @(toValue);
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:nil];
    return animation;
}
/**
 旋转动画动画
 */
- (void)rotationAnimationClockwise:(BOOL)clocwise{
    
    //逆时针旋转
    CGFloat startAngle = 0.0;
    CGFloat endAngle = -M_PI_2;
    CGFloat duration = animationDuration * 0.75;
    //顺时针旋转
    if (clocwise) {
        startAngle = -M_PI_2;
        endAngle = 0.0;
        duration = animationDuration;
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = duration;
    animation.fromValue = @(startAngle);
    animation.toValue = @(endAngle);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.layer addAnimation:animation forKey:nil];
}

/**
 三角形透明动画
 */
- (void)triangleAlphaAnimatioFrom:(CGFloat)from to:(CGFloat)to duration:(CGFloat)duration{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.fromValue = @(from);
    animation.toValue = @(to);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_triangleContainer addAnimation:animation forKey:nil];
}

#pragma mark -- setter方法 --

- (void)setPlayState:(LRYouKuPlayButtonState)playState{
    if (_isAnimationing) {return;}
    _playState = playState;
    _isAnimationing = YES;
    if (playState == LRYouKuPlayButtonStatePlay) {
        [self playAniamtion];
    }else{
        [self pauseAnimation];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isAnimationing = NO;
    });
}
/**
 暂停->播放动画
 */
- (void)playAniamtion{
    //收直线、放圆圈；直线的速度是圆圈的2倍
    [self strokeEndAnimationFrom:1 to:0 layer:_leftLine duration:animationDuration/2];
    [self strokeEndAnimationFrom:1 to:0 layer:_rightLine duration:animationDuration/2];
    [self strokeEndAnimationFrom:0 to:1 layer:_leftCircle duration:animationDuration];
    [self strokeEndAnimationFrom:0 to:1 layer:_rightCircle duration:animationDuration];
    //开始旋转
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration/4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self rotationAnimationClockwise:NO];
    });
    //三角形
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self triangleAlphaAnimatioFrom:0 to:1 duration:animationDuration/2];
    });
}
/**
 播放->暂停动画
 */
- (void)pauseAnimation{
    //先收圆圈，
    [self strokeEndAnimationFrom:1 to:0 layer:_leftCircle duration:animationDuration];
    [self strokeEndAnimationFrom:1 to:0 layer:_rightCircle duration:animationDuration];
    //隐藏播放三角动画
    [self triangleAlphaAnimatioFrom:1 to:0 duration:animationDuration/2];
    //旋转
    [self rotationAnimationClockwise:YES];
    //收到一半再放直线
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self strokeEndAnimationFrom:0 to:1 layer:_leftLine duration:animationDuration/2];
        [self strokeEndAnimationFrom:0 to:1 layer:_rightLine duration:animationDuration/2];
    });
}
@end
