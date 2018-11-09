//
//  LRDisplayLink.m
//  LRAnimations
//
//  Created by 雷路荣 on 2018/11/9.
//  Copyright © 2018 LeiLuRong. All rights reserved.
//

#import "LRDisplayLink.h"

@interface LRDisplayLink()

@property (nonatomic, copy)void (^event)(void);

@property (nonatomic, weak)id target;

@property (nonatomic, assign)SEL selector;

@end

@implementation LRDisplayLink

+ (CADisplayLink *)displayLinkWithTarget:(id)target mode:(NSRunLoopMode)mode event:(void(^)(void))block{
    LRDisplayLink *lrLink = [[self alloc] init];
    lrLink.event = block;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:lrLink selector:@selector(timeEvent)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:mode];
    return link;
}

- (void)timeEvent{
    if (self.event) {
        self.event();
    }
}

+ (CADisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)sel mode:(NSRunLoopMode)mode{
    LRDisplayLink *lrLink = [[self alloc] init];
    lrLink.selector = sel;
    lrLink.target = target;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:lrLink selector:@selector(handle)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:mode];
    return link;
}

- (void)handle{
    if ([self.target respondsToSelector:self.selector]) {
        [self.target performSelector:self.selector withObject:nil afterDelay:0];
    }
}

- (void)dealloc{
    
    NSLog(@"%s",__func__);
}

@end
