//
//  LRTranstionAnimationPop.m
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/20.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRTranstionAnimationPop.h"
#import "LRTransitionPushController.h"
#import "LRTransitionPopController.h"

@interface LRTranstionAnimationPop()<CAAnimationDelegate>

@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation LRTranstionAnimationPop

#pragma mark -- UIViewControllerAnimatedTransitioning --

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    //获取源控制器 注意不要写成 UITransitionContextFromViewKey
    LRTransitionPopController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取目标控制器 注意不要写成 UITransitionContextToViewKey
    LRTransitionPushController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //注意：添加顺序和push动画相反
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toVc.view];
    [containView addSubview:fromVc.view];
    
    UIButton *button = toVc.button;
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    
    ///按钮中心离屏幕最远的那个角的点
    CGPoint startPoint;
    if (button.frame.origin.x > toVc.view.center.x) {
        
        if (button.frame.origin.y < toVc.view.center.y) {
            //第一象限
            startPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }else{
            //第四象限
            startPoint = CGPointMake(0, 0);
        }
        
    }else{
        
        if (button.frame.origin.y < toVc.view.center.y) {
            //第二象限
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }else{
            //第三象限
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
        
    }
    
    CGPoint endPoint = CGPointMake(button.center.x, button.center.y);
    CGFloat radius = sqrt((endPoint.x-startPoint.x) * (endPoint.x-startPoint.x) + (endPoint.y-startPoint.y) * (endPoint.y-startPoint.y)) - sqrt((button.width/2 * button.width/2) + (button.height/2 * button.height/2));
    
    //一开始是很大的圆，执行动画往里面回缩
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    //注意是赋值给fromVc视图layer的mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:nil];
}


#pragma mark -- CAAnimationDelegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self.transitionContext completeTransition:YES];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}

@end
