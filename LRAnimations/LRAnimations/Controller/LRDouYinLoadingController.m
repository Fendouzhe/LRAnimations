//
//  LRDouYinLoadingController.m
//  LRAnimations
//
//  Created by 雷路荣 on 2018/12/17.
//  Copyright © 2018 LeiLuRong. All rights reserved.
//

#import "LRDouYinLoadingController.h"
#import "LRDouYinLoading.h"

@interface LRDouYinLoadingController ()

@end

@implementation LRDouYinLoadingController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    [LRDouYinLoading showInView:self.view];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[LRDouYinLoading hiddenInView:self.view];
    });
}



@end
