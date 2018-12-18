//
//  LRYouKuPlayButton.h
//  XLPlayButtonExample
//
//  Created by 雷路荣 on 2018/12/18.
//  Copyright © 2018 mxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LRYouKuPlayButtonState){
    LRYouKuPlayButtonStatePause,
    LRYouKuPlayButtonStatePlay
};

@interface LRYouKuPlayButton : UIButton

@property (nonatomic, assign) LRYouKuPlayButtonState playState;

- (instancetype)initWithFrame:(CGRect)frame playState:(LRYouKuPlayButtonState)playState;

@end

NS_ASSUME_NONNULL_END
