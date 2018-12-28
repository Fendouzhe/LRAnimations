//
//  LRPaymentSuccessHUD.h
//  XLPaymentHUDExample
//
//  Created by 雷路荣 on 2018/12/28.
//  Copyright © 2018 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRPaymentSuccessHUD : UIView

+(instancetype)showInView:(UIView *)view;

+(instancetype)hideInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
