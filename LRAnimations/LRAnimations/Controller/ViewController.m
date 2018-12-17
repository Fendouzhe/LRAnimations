//
//  ViewController.m
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/7.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "ViewController.h"
#import "LRItem.h"
#import "LRReplicatorLineController.h"
#import "LRMixedColorProgressController.h"
#import "LRGlowViewController.h"
#import "LRElectrocardiogramController.h"
#import "LRFadeViewController.h"
#import "LRShineLabelController.h"
#import "LRTransitionPushController.h"
#import "LRColorProgressController.h"
#import "LRMulticolorViewController.h"
#import "LRColorImageViewController.h"
#import "LRChangeImageController.h"
#import "LREmitterSnowController.h"
#import "LRUnlockAnimationController.h"
#import "LRGlowContentController.h"
#import "LRWaterWaveController.h"
#import "LRDouYinLoadingController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LRAnimations";
    self.items = [NSMutableArray array];
    [self.items addObject:[LRItem itemWithName:@"UILabel混色显示" class:[LRMixedColorProgressController class]]];
    [self.items addObject:[LRItem itemWithName:@"辉光动画" class:[LRGlowViewController class]]];
    [self.items addObject:[LRItem itemWithName:@"心电图动画" class:[LRElectrocardiogramController class]]];
    [self.items addObject:[LRItem itemWithName:@"view的辉光效果" class:[LRFadeViewController class]]];
    [self.items addObject:[LRItem itemWithName:@"绚丽彩色圆弧" class:[LRMulticolorViewController class]]];
    [self.items addObject:[LRItem itemWithName:@"UILabel闪耀效果" class:[LRShineLabelController class]]];
    [self.items addObject:[LRItem itemWithName:@"控制器转场动画" class:[LRTransitionPushController class]]];
    [self.items addObject:[LRItem itemWithName:@"彩色进度条" class:[LRColorProgressController class]]];
    [self.items addObject:[LRItem itemWithName:@"图片带色差动画" class:[LRColorImageViewController class]]];
    [self.items addObject:[LRItem itemWithName:@"带色差切换图片" class:[LRChangeImageController class]]];
    [self.items addObject:[LRItem itemWithName:@"粒子动画雪花效果" class:[LREmitterSnowController class]]];
    [self.items addObject:[LRItem itemWithName:@"滑动解锁动画" class:[LRUnlockAnimationController class]]];
    [self.items addObject:[LRItem itemWithName:@"带辉光的文字图片" class:[LRGlowContentController class]]];
    [self.items addObject:[LRItem itemWithName:@"水波纹" class:[LRWaterWaveController class]]];
    //[self.items addObject:[LRItem itemWithName:@"线性重复动画" class:[LRReplicatorLineController class]]];
    [self.items addObject:[LRItem itemWithName:@"抖音加载动画" class:[LRDouYinLoadingController class]]];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LRItem *item = self.items[indexPath.row];
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.selectionStyle = 0;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%lu. %@",indexPath.row+1,item.name];
    cell.detailTextLabel.text = NSStringFromClass(item.clas);//[NSString stringWithFormat:@"   %@",NSStringFromClass(item.clas)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LRItem *item = self.items[indexPath.row];
    UIViewController *vc = [[item.clas alloc] init];
    vc.title = item.name;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
