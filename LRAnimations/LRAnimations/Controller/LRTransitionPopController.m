//
//  LRTransitionPopController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/20.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRTransitionPopController.h"
#import "LRTranstionAnimationPop.h"

@interface LRTransitionPopController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation LRTransitionPopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:gestureRecognizer];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    
    /*调用UIPercentDrivenInteractiveTransition的updateInteractiveTransition:方法可以控制转场动画进行到哪了，
     当用户的下拉手势完成时，调用finishInteractiveTransition或者cancelInteractiveTransition，UIKit会自动执行剩下的一半动画，
     或者让动画回到最开始的状态。*/
    
    
    if ([gestureRecognizer translationInView:self.view].x>=0) {
        //手势滑动的比例
        CGFloat per = [gestureRecognizer translationInView:self.view].x / (self.view.bounds.size.width);
        per = MIN(1.0,(MAX(0.0, per)));
        
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            
            self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            
            if([gestureRecognizer translationInView:self.view].x ==0){
                
                [self.interactiveTransition updateInteractiveTransition:0.01];
                
            }else{
                
                [self.interactiveTransition updateInteractiveTransition:per];
            }
            
        } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled){
            
            if([gestureRecognizer translationInView:self.view].x == 0){
                
                [self.interactiveTransition cancelInteractiveTransition];
                self.interactiveTransition = nil;
                
            }else if (per > 0.5) {
                
                [ self.interactiveTransition finishInteractiveTransition];

            }else{
                
                [ self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
        }
        
        
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){

        [self.interactiveTransition updateInteractiveTransition:0.01];
        [self.interactiveTransition cancelInteractiveTransition];
  
    } else if ((gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled)){
        
        self.interactiveTransition = nil;
    }
    
}

//为这个动画添加用户交互
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return self.interactiveTransition;
}

#pragma mark -- UINavigationControllerDelegate --

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return [LRTranstionAnimationPop new];
    }else{
        return nil;
    }
}


@end
