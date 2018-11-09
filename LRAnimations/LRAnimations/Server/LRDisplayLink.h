//
//  LRDisplayLink.h
//  LRAnimations
//
//  Created by 雷路荣 on 2018/11/9.
//  Copyright © 2018 LeiLuRong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRDisplayLink : NSObject

+ (CADisplayLink *)displayLinkWithTarget:(id)target mode:(NSRunLoopMode)mode event:(void(^)(void))block;

+ (CADisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)sel mode:(NSRunLoopMode)mode;

@end

NS_ASSUME_NONNULL_END
