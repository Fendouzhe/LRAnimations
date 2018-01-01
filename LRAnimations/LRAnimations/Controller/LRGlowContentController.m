//
//  LRGlowContentController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/25.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRGlowContentController.h"

@interface LRGlowContentController ()

@end

@implementation LRGlowContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    // label
    UILabel *glowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    glowLabel.center = self.view.center;
    glowLabel.text = @"LeiLuRong...";
    glowLabel.textAlignment = NSTextAlignmentCenter;
    glowLabel.textColor = [UIColor whiteColor];
    glowLabel.font = [UIFont systemFontOfSize:28];
    [self.view addSubview:glowLabel];
    
    glowLabel.glowRadius = @(2.f);
    glowLabel.glowOpacity = @(1.f);
    glowLabel.glowColor = [UIColor cyanColor];
    
    glowLabel.glowDuration = @(1.f);
    glowLabel.hideDuration = @(0.3);
    glowLabel.glowAnimationDuration = @(1.5f);
    
    [glowLabel createGlowLayer];
    [glowLabel insertGlowLayer];
    [glowLabel startGlowLoop];
    
    
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    imageView.center = CGPointMake(self.view.center.x, 400);
    imageView.image = [UIImage imageNamed:@"collection_new"];
    [self.view addSubview:imageView];
    
    imageView.glowRadius = @(2.f);
    imageView.glowOpacity = @(0.5f);
    imageView.glowColor = [UIColor whiteColor];
    
    imageView.glowDuration = @1.5;
    imageView.hideDuration = @0.5;
    imageView.glowAnimationDuration = @1.5;
    
    [imageView createGlowLayer];
    [imageView insertGlowLayer];
    [imageView startGlowLoop];
    
}



@end
