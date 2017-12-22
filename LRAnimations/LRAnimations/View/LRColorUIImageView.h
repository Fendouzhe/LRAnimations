//
//  LRColorUIImageView.h
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/22.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UP,    // 从上往下
    DOWN,  // 从下往上
    RIGHT, // 从右往左
    LEFT,  // 从左往右
} EColorDirection;


@interface LRColorUIImageView : UIImageView

/**
 *  确定方向（可以做动画）
 */
@property (nonatomic, assign) EColorDirection  direction;

/**
 *  颜色（可以做动画）
 */
@property (nonatomic, strong) UIColor  *color;

/**
 *  百分比（可以做动画）
 */
@property (nonatomic, assign) CGFloat   percent;

@end

