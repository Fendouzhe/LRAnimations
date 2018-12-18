//
//  LRPlayButtonController.m
//  LRAnimations
//
//  Created by 雷路荣 on 2018/12/18.
//  Copyright © 2018 LeiLuRong. All rights reserved.
//

#import "LRPlayButtonController.h"
#import "LRYouKuPlayButton.h"
#import "LRIQiYiPlayButton.h"

@interface LRPlayButtonController (){
    
    LRYouKuPlayButton *_youKuButton;
    
    LRIQiYiPlayButton *_iQiYiButton;
}
@end

@implementation LRPlayButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat width = 68;
    _youKuButton = [[LRYouKuPlayButton alloc] initWithFrame:CGRectMake(0, 0, width, width) playState:LRYouKuPlayButtonStatePlay];
    //_youKuButton.backgroundColor = [UIColor blackColor];
    _youKuButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height*1/4);
    [_youKuButton addTarget:self action:@selector(youKuPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_youKuButton];
    
    //创建播放按钮，需要初始化一个状态，即显示暂停还是播放状态
    _iQiYiButton = [[LRIQiYiPlayButton alloc] initWithFrame:CGRectMake(0, 0, width, width) playState:LRIQiYiPlayButtonStatePlay];
    //_iQiYiButton.backgroundColor = [UIColor blackColor];
    _iQiYiButton.center = CGPointMake(self.view.center.x, self.view.bounds.size.height*1/2);
    [_iQiYiButton addTarget:self action:@selector(iQiYiPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_iQiYiButton];
    
}

- (void)youKuPlay{
    if (_youKuButton.playState == LRYouKuPlayButtonStatePlay) {
        _youKuButton.playState = LRYouKuPlayButtonStatePause;
    }else{
        _youKuButton.playState = LRYouKuPlayButtonStatePlay;
    }
}

- (void)iQiYiPlay{
    if (_iQiYiButton.playState == LRIQiYiPlayButtonStatePlay) {
        _iQiYiButton.playState = LRIQiYiPlayButtonStatePause;
    }else{
        _iQiYiButton.playState = LRIQiYiPlayButtonStatePlay;
    }
}

@end
