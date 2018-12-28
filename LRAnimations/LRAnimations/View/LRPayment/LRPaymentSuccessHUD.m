//
//  LRPaymentSuccessHUD.m
//  XLPaymentHUDExample
//
//  Created by 雷路荣 on 2018/12/28.
//  Copyright © 2018 MengXianLiang. All rights reserved.
//

#import "LRPaymentSuccessHUD.h"

static CGFloat lineWidth = 4.f;
static CGFloat circleDuration = 0.5f;
static CGFloat checkDuration = 0.25f;

#define BlueColor [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1]

@interface LRPaymentSuccessHUD(){
    CALayer *_animationLayer;
}

@end

@implementation LRPaymentSuccessHUD


+ (instancetype)showInView:(UIView *)view{
    [self hideInView:view];
    LRPaymentSuccessHUD *hud = [[self alloc] initWithFrame:view.bounds];
    [hud start];
    [view addSubview:hud];
    return hud;
}

+ (instancetype)hideInView:(UIView *)view{
    LRPaymentSuccessHUD *hud = nil;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[LRPaymentSuccessHUD class]]) {
            hud = (LRPaymentSuccessHUD *)subView;
            [hud hide];
            [hud removeFromSuperview];
            break;
        }
    }
    return hud;
}

- (void)start{
    [self circleAniamtion];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(circleDuration * 0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkAnimation];
    });
}

- (void)hide{
    for (CALayer *layer in _animationLayer.sublayers) {
        [layer removeAllAnimations];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    _animationLayer = [CALayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, 60, 60);
    _animationLayer.position = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    [self.layer addSublayer:_animationLayer];
}

- (void)circleAniamtion{
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = _animationLayer.bounds;
    [_animationLayer addSublayer:circleLayer];
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = BlueColor.CGColor;
    circleLayer.lineWidth = lineWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleLayer.position radius:(circleLayer.bounds.size.width-lineWidth)*0.5 startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:YES];
    circleLayer.path = path.CGPath;
    
    CABasicAnimation *animtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animtion.duration = circleDuration;
    animtion.fromValue = @0;
    animtion.toValue = @1;
    [circleLayer addAnimation:animtion forKey:nil];
}

- (void)checkAnimation{
    CGFloat width = _animationLayer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width*0.27, width*0.54)];
    [path addLineToPoint:CGPointMake(width*0.45, width*0.7)];
    [path addLineToPoint:CGPointMake(width*0.78, width*0.38)];
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = BlueColor.CGColor;
    checkLayer.lineWidth = lineWidth;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [_animationLayer addSublayer:checkLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = checkDuration;
    animation.fromValue = @0;
    animation.toValue = @1;
    [checkLayer addAnimation:animation forKey:nil];
}

@end
