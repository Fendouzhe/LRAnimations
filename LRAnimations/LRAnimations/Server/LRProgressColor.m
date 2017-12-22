//
//  LRProgressColor.m
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/21.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import "LRProgressColor.h"

@implementation LRProgressColor

- (instancetype)init{
    if (self = [super init]) {
        
        self.startPoint = CGPointMake(0.f, 0.5f);
        self.endPoint   = CGPointMake(1.f, 0.5f);
        self.duration   = 0.1f;
        
    }
    return self;
}

- (NSArray *)accessColors{
    
    NSMutableArray *mutableArr = [_cgColors mutableCopy];
    //第一个和最后一个颜色交换实现位移
    id last = mutableArr.lastObject;
    [mutableArr removeLastObject];
    [mutableArr insertObject:last atIndex:0];
    
    NSArray *colors = [NSArray arrayWithArray:mutableArr];
    return colors;
}

+ (instancetype)redGradientColor{
    
    LRProgressColor *color = [[self alloc] init];
    
    NSMutableArray *cgColors = [NSMutableArray array];
    [cgColors addObject:(id)[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.3f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.4f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.5f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.6f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.7f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.8f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.9f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:1.0f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.9f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.8f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.7f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.6f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.5f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.4f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.3f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f].CGColor];
    [cgColors addObject:(id)[UIColor colorWithRed:0.2f green:0.f blue:0.f alpha:1.f].CGColor];
    
    color.cgColors = cgColors;
    color.duration = 0.1f;
    return color;
}


@end
