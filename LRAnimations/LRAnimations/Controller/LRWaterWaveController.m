//
//  LRWaterWaveController.m
//  LRAnimations
//
//  Created by 雷路荣 on 2018/11/9.
//  Copyright © 2018 LeiLuRong. All rights reserved.
//

#import "LRWaterWaveController.h"
#import "LRDisplayLink.h"

@interface LRWaterWaveController ()
//振幅--这个决定波形的起伏高度
@property (nonatomic, assign)CGFloat waterAmplitude;
//频率--这个决定波形的宽度
@property (nonatomic, assign)CGFloat waterFrequency;
//初相--这个决定水平移动速度
@property (nonatomic, assign)CGFloat waterEpoch;
//偏距--调节距离顶部的高度
@property (nonatomic, assign)CGFloat waterSetover;
//波形整个宽度
@property (nonatomic, assign)CGFloat waterWaveWidth;
//波形整个高度
@property (nonatomic, assign)CGFloat waterWaveHight;

@property (nonatomic, strong)CADisplayLink *link;

@property (nonatomic, strong)CAShapeLayer *waterWaveLayer;

@end

@implementation LRWaterWaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _waterWaveLayer = [CAShapeLayer layer];
    _waterWaveLayer.frame = CGRectMake(0, 100, self.view.width, self.view.height-100);//self.view.bounds;
    _waterWaveLayer.fillColor = [UIColor blueColor].CGColor;
    //_waterWaveLayer.strokeColor = [UIColor redColor].CGColor;
    //_waterWaveLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_waterWaveLayer];
    
    _waterWaveWidth = _waterWaveLayer.frame.size.width;
    _waterWaveHight = _waterWaveLayer.frame.size.height;
    
    _waterAmplitude = 15.f;
    //假设在frame的长度上出现3个完整的波形:注意这里乘以0.5出现震荡效果,如果不乘以0.5只会出现波形平移的效果。
    _waterFrequency = 2*M_PI*3/_waterWaveWidth*0.5;
    _waterEpoch = 0.f;
    _waterSetover = 20.f;
    
    __weak typeof(self) weakSelf = self;
    _link = [LRDisplayLink displayLinkWithTarget:self mode:NSRunLoopCommonModes event:^{

        [weakSelf waterWaveAnimation];
    }];
    
    //_link = [LRDisplayLink displayLinkWithTarget:self selector:@selector(waterWaveAnimation) mode:NSRunLoopCommonModes];
}

- (void)waterWaveAnimation{
    //增大可加快速度
    _waterEpoch += 0.1;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    for (CGFloat x=0; x<_waterWaveWidth; x++) {
        /*
         高中知识:y = Asin(wx + θ) + k;
         
         其中A：代表振幅; w:角频率，和周期的关系是:T = 2π/|w| ;θ:初相,相对于标准的正弦公式y = sin(x)而言,θ代表
         
         标准的正弦公式y = sin(x)在水平(x轴)方向上的整体移动，即左加右减;k:偏距,代表标准的正弦公式y = sin(x)在 垂直(y轴)方向上的整体移动,即上加下减。
         
         由表达式 y = sin(x)我们知道:在[0,2π]的区间上绘制一个完整的正弦波形,周期刚好是2π(T= 2π/|w|) 这里w = 1;绘制2个完整的正弦波形,周期为π。所以可以把w理解成完整波形的个数。由此可以得出:在区间[0,waveWidth]上绘制n个完整的波形,w = 2π * n / waveWidth。另外还要注意一点就是UIKit框架坐标轴是向下的。
         
         上面的知识也只是对正弦公式进行回顾。怎么样才能得到波形效果呢？关键点就在初相θ身上。
         */
        CGFloat y = _waterAmplitude*sinf(_waterFrequency * x + _waterEpoch) + _waterSetover;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(_waterWaveWidth, _waterWaveHight)];
    [path addLineToPoint:CGPointMake(0, _waterWaveHight)];
    [path closePath];
    _waterWaveLayer.path = path.CGPath;
}

- (void)dealloc{
    
    [_link invalidate];
    _link = nil;
    NSLog(@"%s",__func__);
}


@end
