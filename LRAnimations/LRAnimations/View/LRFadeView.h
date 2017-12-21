//
//  LRFadeView.h
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/11.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRFadeView : UIView

/**
 *  输入文本
 */
@property (nonatomic, strong) NSString *text;


/**
 *  向右渐变消失
 */
- (void)fadeRight;

@end
