//
//  LRItem.h
//  LRAnimations
//
//  Created by LeiLuRong on 2017/12/7.
//  Copyright © 2017年 LeiLuRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRItem : NSObject

@property (nonatomic, copy)NSString *name;

@property (nonatomic, strong)Class clas;

+(instancetype)itemWithName:(NSString *)name class:(Class)clas;

@end
