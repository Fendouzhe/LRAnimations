//
//  LRFadeView.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/11.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRFadeView.h"

@interface LRFadeView()

@property (nonatomic, strong)UILabel *label;

@property (nonatomic, strong)UILabel *backLabel;

@property (nonatomic, strong)UIView *mask;

@end

@implementation LRFadeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createLabel:self.bounds];
        
        [self createMask:self.bounds];
    }
    return self;
}

- (void)createLabel:(CGRect)frame {
    self.label               = [[UILabel alloc] initWithFrame:frame];
    self.label.font          = [UIFont systemFontOfSize:45.f];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor     = [[UIColor cyanColor] colorWithAlphaComponent:0.5f];
    
    [self addSubview:self.label];
}

- (void)createMask:(CGRect)frame {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations = @[@(0.01),@(0.2),@(0.4),@(0.59)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    self.mask = [[UIView alloc] initWithFrame:frame];
    [self.mask.layer addSublayer:gradientLayer];
    
    CGRect newFrame = self.mask.frame;
    newFrame.origin.x -= 200;
    self.mask.frame = newFrame;
    
    self.maskView = self.mask;
    
}


- (void)fadeRight{
    [UIView animateWithDuration:5.f animations:^{
        CGRect frame    = self.mask.frame;
        frame.origin.x += (frame.size.width + 400);
        self.mask.frame = frame;
    } completion:^(BOOL finished) {

    }];
}

/**
 *  重写setter,getter方法
 */
@synthesize text = _text;
- (void)setText:(NSString *)text {
    _text           = text;
    self.label.text = text;
}
- (NSString *)text {
    return _text;
}

@end






