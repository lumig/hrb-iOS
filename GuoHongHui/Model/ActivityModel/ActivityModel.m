//
//  ActivityModel.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

static ActivityModel *g_ActivityModel;

+(ActivityModel *)shareActivityModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_ActivityModel = [[self alloc] init];
    });
    return g_ActivityModel;
}


+ (ActivityModel *)fetchActivityModel:(NSDictionary *)dic
{
    ActivityModel *model = [[ActivityModel alloc] init];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        //这里的key要和定义的字段保持一致
        [model setValuesForKeysWithDictionary:dic];
    }
    
    return model;
}

- (ActivityModel *)fetchActivityModel:(NSDictionary *)dic
{
    ActivityModel *model = [[ActivityModel alloc] init];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        //这里的key要和定义的字段保持一致
        [model setValuesForKeysWithDictionary:dic];
    }
    
    return model;
}


@end
