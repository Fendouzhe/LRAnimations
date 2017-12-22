//
//  LRColorFullProgressView.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/21.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRColorFullProgressView.h"

@interface LRColorFullProgressView()<CAAnimationDelegate>{
    
    /**
     *  当前view宽度
     */
    CGFloat _width;
    
    /**
     *  当前view高度 用于记录原始高度
     */
    CGFloat _height;
}

@property (nonatomic, strong)UIView *baseView;

@property (nonatomic, strong)CAGradientLayer *gradientLayer;

@end

@implementation LRColorFullProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _width = self.frame.size.width;
        _height = self.frame.size.height;
        
        // baseView
        self.baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, _height)];
        _baseView.layer.masksToBounds = YES;
        [self addSubview:_baseView];
        
        // gradientLayer
        self.gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        [self.baseView.layer addSublayer:_gradientLayer];
        
        
    }
    return self;
}

- (void)configAvailableAndBegin{
    
    // 如果没有设置ProgressColor,则自己生成一个
    if (_progressColor == nil) {
        
        _progressColor = [[LRProgressColor alloc] init];
        
        NSMutableArray *cgColors = [NSMutableArray array];
        for (NSInteger i = 0; i < 360; i+=5) {
            //指定HSB，参数是：色调（hue），饱和的（saturation），亮度（brightness）
            UIColor *color = [UIColor colorWithHue:i/360.0 saturation:1.0 brightness:1.0 alpha:1.0];
            [cgColors addObject:(__bridge id)color.CGColor];
        }
        _progressColor.cgColors = cgColors;
    }
    
    _gradientLayer.colors = _progressColor.cgColors;
    _gradientLayer.startPoint = _progressColor.startPoint;
    _gradientLayer.endPoint = _progressColor.endPoint;
    
    [self animation];
}

- (void)animation{
    
    NSArray *fromColors = _progressColor.cgColors;
    //获取最后一帧
    NSArray *toClors = [_progressColor accessColors];
    _progressColor.cgColors = toClors;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.fromValue = fromColors;
    animation.toValue = toClors;
    animation.duration = _progressColor.duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    //layerhuadh
    //防止复原 removedOnCompletion == YES 则需要设置动画完后最终颜色
    _gradientLayer.colors = toClors;
    [_gradientLayer addAnimation:animation forKey:@"colorsAnimation"];

}

#pragma mark-- CAAnimationDelegate --

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self animation];
}

+ (instancetype)colorfulProgressViewWithFrame:(CGRect)frame progressColor:(LRProgressColor *)progressColor{
    
    LRColorFullProgressView *progressView = [[self alloc] initWithFrame:frame];
    if (progressColor) {
        progressView.progressColor = progressColor;
    }
    [progressView configAvailableAndBegin];
    
    return progressView;
}

#pragma mark -- 重写getter,setter方法 --

@synthesize progress = _progress;
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (progress <= 0) {
        _baseView.frame = CGRectMake(0, 0, 0, _height);
    }else if (progress <= 1){
        _baseView.frame = CGRectMake(0, 0, _width*progress, _height);
    }else{
        _baseView.frame = CGRectMake(0, 0, _width, _height);
    }
}

- (CGFloat)progress{
    return _progress;
}



@end
