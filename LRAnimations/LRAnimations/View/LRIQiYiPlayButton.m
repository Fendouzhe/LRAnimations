//
//  LRIQiYiPlayButton.m
//  XLPlayButtonExample
//
//  Created by 雷路荣 on 2018/12/18.
//  Copyright © 2018 mxl. All rights reserved.
//

#import "LRIQiYiPlayButton.h"

//其它动画时长
static CGFloat animationDuration = 0.5f;
//位移动画时长
static CGFloat positionDuration = 0.3f;
//线条颜色
#define LineColor [UIColor colorWithRed:12/255.0 green:190/255.0 blue:6/255.0 alpha:1]
//三角动画名称
#define TriangleAnimation @"TriangleAnimation"
//右侧直线动画名称
#define RightLineAnimation @"RightLineAnimation"

#define AnimationName @"animationName"

@interface LRIQiYiPlayButton()<CAAnimationDelegate>{
    //左边竖线
    CAShapeLayer *_leftLine;
    //三角
    CAShapeLayer *_triangle;
    //右边竖线
    CAShapeLayer *_rightLine;
    //右边半圆弧
    CAShapeLayer *_circle;
    
    BOOL _isAnimationing;
}

@end

@implementation LRIQiYiPlayButton

- (instancetype)initWithFrame:(CGRect)frame playState:(LRIQiYiPlayButtonState)playState{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        if (playState == LRIQiYiPlayButtonStatePlay) {
            self.playState = playState;
        }
    }
    return self;
}

- (void)buildUI{
    //self.playState = LRIQiYiPlayButtonStatePause;
    [self addTriangleLayer];
    [self addLeftLineLayer];
    [self addRightLineLayer];
    [self addCircleLayer];
}

- (void)addTriangleLayer{
    CGFloat width = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.2, width*0.2)];
    [path addLineToPoint:CGPointMake(width*0.2, 0)];
    [path addLineToPoint:CGPointMake(width, width*0.5)];
    [path addLineToPoint:CGPointMake(width*0.2, width)];
    [path addLineToPoint:CGPointMake(width*0.2, width*0.2)];
    //[path closePath];
    
    _triangle = [CAShapeLayer layer];
    _triangle.path = path.CGPath;
    _triangle.lineWidth = [self lineWidth];
    _triangle.fillColor = [UIColor clearColor].CGColor;
    _triangle.strokeColor = LineColor.CGColor;
    _triangle.lineCap = kCALineCapButt;
    _triangle.lineJoin = kCALineJoinRound;
    _triangle.strokeEnd = 0;
    [self.layer addSublayer:_triangle];
}

- (void)addLeftLineLayer{
    CGFloat width = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.2, 0)];
    [path addLineToPoint:CGPointMake(width*0.2, width)];

    _leftLine = [CAShapeLayer layer];
    _leftLine.path = path.CGPath;
    _leftLine.lineWidth = [self lineWidth];
    _leftLine.fillColor = [UIColor clearColor].CGColor;
    _leftLine.strokeColor = LineColor.CGColor;
    _leftLine.lineCap = kCALineJoinRound;
    _leftLine.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_leftLine];
}

- (void)addRightLineLayer{
    CGFloat width = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.8, width)];
    [path addLineToPoint:CGPointMake(width*0.8, 0)];
    
    _rightLine = [CAShapeLayer layer];
    _rightLine.path = path.CGPath;
    _rightLine.lineWidth = [self lineWidth];
    _rightLine.fillColor = [UIColor clearColor].CGColor;
    _rightLine.strokeColor = LineColor.CGColor;
    _rightLine.lineCap = kCALineJoinRound;
    _rightLine.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_rightLine];
}

- (void)addCircleLayer{
    CGFloat width = self.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.8, width*0.8)];
    [path addArcWithCenter:CGPointMake(width*0.5, width*0.8) radius:(width-0.2*width*2)*0.5 startAngle:0 endAngle:M_PI clockwise:YES];
    
    _circle = [CAShapeLayer layer];
    _circle.path = path.CGPath;
    _circle.lineWidth = [self lineWidth];
    _circle.fillColor = [UIColor clearColor].CGColor;
    _circle.strokeColor = LineColor.CGColor;
    _circle.lineCap = kCALineJoinRound;
    _circle.lineJoin = kCALineJoinRound;
    _circle.strokeEnd = 0;
    [self.layer addSublayer:_circle];
}

//线条宽度，根据按钮的宽度按比例设置
- (CGFloat)lineWidth {
    return self.bounds.size.width * 0.2;
}

#pragma mark -- 动画执行方法 --
/**
 执行正向动画，即暂停->播放
 */
- (void)positiveAnimation{
    //开始三角动画
    [self strokeEndAnimationWithLayer:_triangle from:0 to:1 name:TriangleAnimation duration:animationDuration delegate:self];
    //开始右侧线条动画
    [self strokeEndAnimationWithLayer:_rightLine from:1 to:0 name:RightLineAnimation duration:animationDuration/4 delegate:self];
    //开始画弧动画
    [self strokeEndAnimationWithLayer:_circle from:0 to:1 name:nil duration:animationDuration/4 delegate:nil];
    //开始逆向画弧线动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration*0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self circleStartAnimationFrom:0 to:1];
    });
    //开始左侧线条缩短动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration*0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //左侧竖线动画
        [self strokeEndAnimationWithLayer:_leftLine from:1 to:0 name:nil duration:animationDuration/2 delegate:nil];
    });
}

/**
 执行逆向动画，即播放->暂停
 */
- (void)inverseAnimation{
    //开始三角动画
    [self strokeEndAnimationWithLayer:_triangle from:1 to:0 name:TriangleAnimation duration:animationDuration delegate:self];
    //左侧竖线动画
    [self strokeEndAnimationWithLayer:_leftLine from:0 to:1 name:nil duration:animationDuration/2 delegate:nil];
    //开始画弧线动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration*0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self circleStartAnimationFrom:1 to:0];
    });

    //开始左侧线条缩短动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration*0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //开始右侧线条动画
        [self strokeEndAnimationWithLayer:_rightLine from:0 to:1 name:RightLineAnimation duration:animationDuration/4 delegate:self];
        //开始画弧动画
        [self strokeEndAnimationWithLayer:_circle from:1 to:0 name:nil duration:animationDuration/4 delegate:nil];
    });
}

/**
 通用执行strokeEnd动画
 */
- (CABasicAnimation *)strokeEndAnimationWithLayer:(CALayer *)layer from:(CGFloat)fromValue to:(CGFloat)toValue name:(NSString *)animationName duration:(CGFloat)duration delegate:(id)delegate{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = @(fromValue);
    animation.toValue = @(toValue);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setValue:animationName forKey:AnimationName];
    animation.delegate = delegate;
    [layer addAnimation:animation forKey:nil];
    return animation;
}

/**
 画弧改变起始位置动画
 */
- (void)circleStartAnimationFrom:(CGFloat)fromValue to:(CGFloat)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.duration = animationDuration/4;
    animation.fromValue = @(fromValue);
    animation.toValue = @(toValue);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_circle addAnimation:animation forKey:nil];
}

#pragma mark -- CAAnimationDelegate --
- (void)animationDidStart:(CAAnimation *)anim{
    NSString *name = [anim valueForKey:AnimationName];
    if ([name isEqualToString:TriangleAnimation]) {
        _triangle.lineCap = kCALineCapRound;
    }else if ([name isEqualToString:RightLineAnimation]){
        _rightLine.lineCap = kCALineCapRound;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSString *name = [anim valueForKey:AnimationName];
    if ([name isEqualToString:RightLineAnimation] && self.playState == LRIQiYiPlayButtonStatePlay) {
        _rightLine.lineCap = kCALineCapButt;
    }else if ([name isEqualToString:TriangleAnimation]){
        _triangle.lineCap = kCALineCapButt;
    }
}

#pragma mark -- 竖线动画 --
//暂停->播放竖线动画
- (void)linePositiveAniamtion{
    CGFloat width = self.bounds.size.width;
    
    UIBezierPath *leftPath1 = [UIBezierPath bezierPath];
    [leftPath1 moveToPoint:CGPointMake(width*0.2, width*0.4)];
    [leftPath1 addLineToPoint:CGPointMake(width*0.2, width)];
    _leftLine.path = leftPath1.CGPath;
    [_leftLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
    
    UIBezierPath *rightPath1 = [UIBezierPath bezierPath];
    [rightPath1 moveToPoint:CGPointMake(width*0.8, width*0.8)];
    [rightPath1 addLineToPoint:CGPointMake(width*0.8, -0.2*width)];
    _rightLine.path = rightPath1.CGPath;
    [_rightLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIBezierPath *leftPath2 = [UIBezierPath bezierPath];
        [leftPath2 moveToPoint:CGPointMake(width*0.2, width*0.2)];
        [leftPath2 addLineToPoint:CGPointMake(width*0.2, width*0.8)];
        _leftLine.path = leftPath2.CGPath;
        [_leftLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
        
        UIBezierPath *rightPath2 = [UIBezierPath bezierPath];
        [rightPath2 moveToPoint:CGPointMake(width*0.8, width*0.8)];
        [rightPath2 addLineToPoint:CGPointMake(width*0.8, width*0.2)];
        _rightLine.path = rightPath2.CGPath;
        [_rightLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
        
    });
    
}

//播放->暂停竖线动画
- (void)lineInverseAniamtion{
    CGFloat width = self.bounds.size.width;
    
    UIBezierPath *leftPath1 = [UIBezierPath bezierPath];
    [leftPath1 moveToPoint:CGPointMake(width*0.2, width*0.4)];
    [leftPath1 addLineToPoint:CGPointMake(width*0.2, width)];
    _leftLine.path = leftPath1.CGPath;
    [_leftLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
    
    UIBezierPath *rightPath1 = [UIBezierPath bezierPath];
    [rightPath1 moveToPoint:CGPointMake(width*0.8, width*0.8)];
    [rightPath1 addLineToPoint:CGPointMake(width*0.8, -0.2*width)];
    _rightLine.path = rightPath1.CGPath;
    [_rightLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIBezierPath *leftPath2 = [UIBezierPath bezierPath];
        [leftPath2 moveToPoint:CGPointMake(width*0.2, 0)];
        [leftPath2 addLineToPoint:CGPointMake(width*0.2, width)];
        _leftLine.path = leftPath2.CGPath;
        [_leftLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
        
        UIBezierPath *rightPath2 = [UIBezierPath bezierPath];
        [rightPath2 moveToPoint:CGPointMake(width*0.8, width)];
        [rightPath2 addLineToPoint:CGPointMake(width*0.8, 0)];
        _rightLine.path = rightPath2.CGPath;
        [_rightLine addAnimation:[self pathAnimtionWithDuration:positionDuration/2] forKey:nil];
        
    });
    
}

/**
 通用path动画方法
 */
- (CABasicAnimation *)pathAnimtionWithDuration:(CGFloat)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

#pragma mark -- Setter方法 --
- (void)setPlayState:(LRIQiYiPlayButtonState)playState{
    if (_isAnimationing) {return;}
    _playState = playState;
    _isAnimationing = YES;
    if (playState == LRIQiYiPlayButtonStatePlay) {
        //竖线正向动画
        [self linePositiveAniamtion];
        //再执行画弧、画三角动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(positionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self positiveAnimation];
        });
    }else if (playState == LRIQiYiPlayButtonStatePause){
        //先执行画弧、画三角动画
        [self inverseAnimation];
        //在执行竖线位移动画，结束动动画要比开始动画块
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  animationDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            //竖线逆向动画
            [self lineInverseAniamtion];
        });
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((animationDuration+positionDuration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isAnimationing = NO;
    });
}

@end
