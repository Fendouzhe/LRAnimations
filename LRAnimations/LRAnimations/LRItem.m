//
//  LRItem.m
//  LRAnimations
//
//  Created by 宇中 on 2017/12/7.
//  Copyright © 2017年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRItem.h"

@implementation LRItem

+(instancetype)itemWithName:(NSString *)name class:(Class)clas{
    LRItem *item = [[self alloc] init];
    item.name = name;
    item.clas = clas;
    return item;
}

@end
