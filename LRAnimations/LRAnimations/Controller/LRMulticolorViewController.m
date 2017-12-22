//
//  LRMulticolorViewController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/22.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRMulticolorViewController.h"
#import "LRMulticolorView.h"

@interface LRMulticolorViewController ()

@property (nonatomic, strong) NSTimer         *timer;
@property (nonatomic, strong) LRMulticolorView  *showView0;
@property (nonatomic, strong) LRMulticolorView  *showView1;

@end

@implementation LRMulticolorViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // _showView1
    _showView0           = [[LRMulticolorView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _showView0.lineWidth = 6.f;
    _showView0.sec       = 2.f;
    _showView0.colors    = @[(id)[UIColor cyanColor].CGColor,
                            (id)[UIColor yellowColor].CGColor,
                            (id)[UIColor cyanColor].CGColor];
    _showView0.center    = CGPointMake(self.view.center.x, 200);
    _timer              = [NSTimer scheduledTimerWithTimeInterval:1
                                                           target:self
                                                         selector:@selector(event:)
                                                         userInfo:nil
                                                          repeats:YES];
    [self.view addSubview:_showView0];
    [_showView0 startAnimation];
    
    // _showView1
    _showView1           = [[LRMulticolorView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _showView1.lineWidth = 6.f;
    _showView1.sec       = 2.f;
    _showView1.colors    = @[(id)[UIColor cyanColor].CGColor,
                             (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor cyanColor].CGColor];
    _showView1.center    = CGPointMake(self.view.center.x, 400);
    _showView1.lineDashPattern = @[@10, @10];
    _timer              = [NSTimer scheduledTimerWithTimeInterval:1
                                                           target:self
                                                         selector:@selector(event:)
                                                         userInfo:nil
                                                          repeats:YES];
    [self.view addSubview:_showView1];
    [_showView1 startAnimation];
    
}

- (void)event:(id)object{
    _showView0.percent = arc4random()%101/100.f;
    _showView1.percent = arc4random()%101/100.f;
}


@end
