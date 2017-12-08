//
//  ViewController.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/7.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "LRItem.h"
#import "LRReplicatorLineController.h"
#import "LRMixedColorProgressController.h"
#import "LRGlowViewController.h"

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
    //[self.items addObject:[LRItem itemWithName:@"线性重复动画" class:[LRReplicatorLineController class]]];
    
    
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
