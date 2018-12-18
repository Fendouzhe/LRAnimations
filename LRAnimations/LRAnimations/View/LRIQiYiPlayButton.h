//
//  LRIQiYiPlayButton.h
//  XLPlayButtonExample
//
//  Created by 雷路荣 on 2018/12/18.
//  Copyright © 2018 mxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LRIQiYiPlayButtonState){
    LRIQiYiPlayButtonStatePause,
    LRIQiYiPlayButtonStatePlay
};

@interface LRIQiYiPlayButton : UIButton

@property (nonatomic, assign)LRIQiYiPlayButtonState playState;

- (instancetype)initWithFrame:(CGRect)frame playState:(LRIQiYiPlayButtonState)playState;

@end

NS_ASSUME_NONNULL_END
