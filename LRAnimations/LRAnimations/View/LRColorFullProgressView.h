//
//  LRColorFullProgressView.h
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/21.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRProgressColor.h"

@interface LRColorFullProgressView : UIView


/**
 进度
 */
@property (nonatomic, assign)CGFloat progress;


/**
 进度颜色
 */
@property (nonatomic, strong)LRProgressColor *progressColor;



/**
 配置生效以及开始运行
 */
- (void)configAvailableAndBegin;


/**
 便利构造器方法

 @param  frame         尺寸
 @param  progressColor 颜色值,可以为空
 @return 实例对象
 */
+ (instancetype)colorfulProgressViewWithFrame:(CGRect)frame progressColor:(LRProgressColor *)progressColor;
@end
