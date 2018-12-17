//
//  LRDouYinLoading.m
//  XLDouYinLoadingExample
//
//  Created by 雷路荣 on 2018/12/17.
//  Copyright © 2018 MXL. All rights reserved.
//

#import "LRDouYinLoading.h"

//球宽度
static CGFloat BallWidth=12.f;
//球速度
static CGFloat BallSpeed=0.7f;
//缩放比例
static CGFloat BallZoomScale=0.25f;
//暂停时间
static CGFloat PauseSecond=0.18f;

typedef NS_ENUM(NSInteger,LRBallMoveDiretion){
    LRBallMoveDiretionPositive=1,//正向
    LRBallMoveDiretionNegative=-1//逆向
};

@interface LRDouYinLoading()

@property (nonatomic, strong)UIView *contaiView;

@property (nonatomic, strong)UIView *greenBall;

@property (nonatomic, strong)UIView *redBall;

@property (nonatomic, strong)UIView *blackBall;

@property (nonatomic, assign)LRBallMoveDiretion direction;

@property (nonatomic, strong)CADisplayLink *displayLink;

@end

@implementation LRDouYinLoading


+ (instancetype)showInView:(UIView *)view{
    LRDouYinLoading *loadView = [[LRDouYinLoading alloc] initWithFrame:view.bounds];
    [view addSubview:loadView];
    [loadView startAnimation];
    return loadView;
}

+ (BOOL)hiddenInView:(UIView *)view{
    NSEnumerator *subEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subView in subEnum) {
        if ([subView isKindOfClass:self]) {
            LRDouYinLoading *loadView = (LRDouYinLoading *)subView;
            [loadView.displayLink invalidate];
            [loadView removeFromSuperview];
            return YES;
        }
    }
    return NO;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buidUI];
    }
    return self;
}

- (void)startAnimation{
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopAnimation{
    [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)pauseAnimation{
    [self stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(PauseSecond * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}

- (void)buidUI{
    self.contaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2.1*BallWidth, 1.68*BallWidth)];
    _contaiView.center = self.center;
    //_contaiView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_contaiView];
    
    self.greenBall = [[UIView alloc] initWithFrame:CGRectMake(0, (_contaiView.frame.size.height-BallWidth)/2, BallWidth, BallWidth)];
    _greenBall.backgroundColor = [UIColor cyanColor];
    _greenBall.layer.cornerRadius = BallWidth*0.5;
    _greenBall.layer.masksToBounds = YES;
    [_contaiView addSubview:_greenBall];
    
    self.redBall = [[UIView alloc] initWithFrame:CGRectMake(_contaiView.frame.size.width-BallWidth, (_contaiView.frame.size.height-BallWidth)/2, BallWidth, BallWidth)];
    _redBall.backgroundColor = [UIColor redColor];
    _redBall.layer.cornerRadius = BallWidth*0.5;
    _redBall.layer.masksToBounds = YES;
    [_contaiView addSubview:_redBall];
    
    self.blackBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BallWidth, BallWidth)];
    _blackBall.backgroundColor = [UIColor blackColor];
    _blackBall.layer.cornerRadius = BallWidth*0.5;
    _blackBall.layer.masksToBounds = YES;
    [_greenBall addSubview:_blackBall];
    
    self.direction = LRBallMoveDiretionPositive;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
}

- (void)update{
    CGPoint greenCenter = _greenBall.center;
    CGPoint redCenter = _redBall.center;
    
    if (_direction == LRBallMoveDiretionPositive) {
        
        greenCenter.x+=BallSpeed;
        _greenBall.center = greenCenter;
        
        redCenter.x-=BallSpeed;
        _redBall.center = redCenter;
        
        //缩放动画,绿球放大 红球变小
        _greenBall.transform = [self ballLargerWithCenterX:greenCenter.x];
        _redBall.transform = [self ballSmallWithCenterX:redCenter.x];
        
        //更新黑球位置
        CGRect blackFrame = [_redBall convertRect:_redBall.bounds toCoordinateSpace:_greenBall];
        _blackBall.frame = blackFrame;
        _blackBall.layer.cornerRadius = _blackBall.bounds.size.width*0.5;
        
        //边界切换
        if (CGRectGetMaxX(_greenBall.frame)>=_contaiView.bounds.size.width || CGRectGetMinX(_redBall.frame)<=0) {
            //切换方向
            _direction = LRBallMoveDiretionNegative;
            //将红球移到最上面
            [_contaiView bringSubviewToFront:_redBall];
            //黑球放在红球上面
            [_redBall addSubview:_blackBall];
            //暂停一会儿
            [self pauseAnimation];
        }
        
    }else if (_direction == LRBallMoveDiretionNegative){
        
        greenCenter.x-=BallSpeed;
        _greenBall.center = greenCenter;
        
        redCenter.x+=BallSpeed;
        _redBall.center = redCenter;
        
        //缩放动画,红球放大 绿/黑球变小
        _greenBall.transform = [self ballSmallWithCenterX:greenCenter.x];
        _redBall.transform = [self ballLargerWithCenterX:redCenter.x];
        
        //更新黑球位置
        CGRect blackFrame = [_greenBall convertRect:_greenBall.bounds toCoordinateSpace:_redBall];
        _blackBall.frame = blackFrame;
        _blackBall.layer.cornerRadius = _blackBall.bounds.size.width*0.5;
        
        if (CGRectGetMaxX(_redBall.frame)>=_contaiView.bounds.size.width || CGRectGetMinX(_greenBall.frame)<=0) {
            _direction = LRBallMoveDiretionPositive;
            [_contaiView bringSubviewToFront:_greenBall];
            [_greenBall addSubview:_blackBall];
            [self pauseAnimation];
        }
        
    }
}

//放大
- (CGAffineTransform)ballLargerWithCenterX:(CGFloat)centerX{
    CGFloat cosValue = [self cosValueWithCenterX:centerX];
    return CGAffineTransformMakeScale(1+cosValue*BallZoomScale, 1+cosValue*BallZoomScale);
}

//缩小
- (CGAffineTransform)ballSmallWithCenterX:(CGFloat)centerX{
    CGFloat cosValue = [self cosValueWithCenterX:centerX];
    return CGAffineTransformMakeScale(1-cosValue*BallZoomScale, 1-cosValue*BallZoomScale);
}

//根据余弦函数获取变化区间 变化范围是0~1~0
- (CGFloat)cosValueWithCenterX:(CGFloat)centerX{
    
    CGFloat apart = centerX-_contaiView.bounds.size.width*0.5;
    //最大距离，球心距离containView最大距离
    CGFloat maxAppart = (_contaiView.bounds.size.width - BallWidth)*0.5;
    //计算角度
    CGFloat angle = apart/maxAppart * M_PI_2;
    //获取比例对应余弦曲线的Y值
    return cos(angle);
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
