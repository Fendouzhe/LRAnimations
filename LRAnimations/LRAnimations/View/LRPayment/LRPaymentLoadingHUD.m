//
//  LRPaymentLoadingHUD.m
//  XLPaymentHUDExample
//
//  Created by 雷路荣 on 2018/12/28.
//  Copyright © 2018 MengXianLiang. All rights reserved.
//

#import "LRPaymentLoadingHUD.h"

static CGFloat lineWidth = 4.0f;
#define BlueColor [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1]

@interface LRPaymentLoadingHUD(){
    
    CADisplayLink *_link;
    CAShapeLayer *_animationLayer;
    
    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _progress;
    
}

@end

@implementation LRPaymentLoadingHUD


+(instancetype)showInView:(UIView *)view{
    [self hideInView:view];
    LRPaymentLoadingHUD *hud = [[LRPaymentLoadingHUD alloc] initWithFrame:view.bounds];
    [hud start];
    [view addSubview:hud];
    return hud;
}

+(instancetype)hideInView:(UIView *)view{
    LRPaymentLoadingHUD *hud = nil;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[LRPaymentLoadingHUD class]]) {
            hud = (LRPaymentLoadingHUD *)subView;
            [hud hide];
            [hud removeFromSuperview];
            break;
        }
    }
    return hud;
}

- (void)start{
    _link.paused = NO;
}

- (void)hide{
    _link.paused = YES;
    [_link invalidate];
    _progress = 0;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    _animationLayer = [CAShapeLayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, 60, 60);
    _animationLayer.position = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    _animationLayer.fillColor = [UIColor clearColor].CGColor;
    _animationLayer.strokeColor = BlueColor.CGColor;
    _animationLayer.lineWidth = lineWidth;
    _animationLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_animationLayer];
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(dispayLinkEvent)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link.paused = NO;
}

- (void)dispayLinkEvent{
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimation];
}

- (void)updateAnimation{
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 + _progress * M_PI * 2;//最大1.5 * M_PI即-M_PI_2
    ///当_endAngle >= M_PI 时 _startAngle 最大1.5 * M_PI即-M_PI_2 最小-4 * M_PI 即 0
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1-(1-_progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;//最大1.5 * M_PI即-M_PI_2 最小-4 * M_PI 即 0
    }
    CGFloat radius = _animationLayer.bounds.size.width/2-lineWidth/2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_animationLayer.bounds.size.width/2, _animationLayer.bounds.size.height/2) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    _animationLayer.path = path.CGPath;
}

- (CGFloat)speed{
    if (_endAngle > M_PI) {
        return 0.3/60.f;
    }
    return 2/60.f;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
