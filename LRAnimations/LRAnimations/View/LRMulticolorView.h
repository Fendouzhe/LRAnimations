//
//  LRMulticolorView.h
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/15.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRMulticolorView : UIView

@property (nonatomic, assign) CGFloat          lineWidth;  // 圆的线宽
@property (nonatomic, assign) CFTimeInterval   sec;        // 秒
@property (nonatomic, assign) CGFloat          percent;    // 百分比

@property (nonatomic, strong) NSArray         *colors;     // 颜色组(CGColor)

@property (nonatomic, strong) NSArray         *lineDashPattern;//断点组

- (void)startAnimation;
- (void)endAnimation;

@end
