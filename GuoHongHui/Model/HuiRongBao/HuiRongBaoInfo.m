//
//  HuiRongBaoInfo.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/18.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiRongBaoInfo.h"

@implementation HuiRongBaoInfo

+(HuiRongBaoInfo *)fetchInfoWithDict:(NSDictionary *)dict
{
    HuiRongBaoInfo *info = [[HuiRongBaoInfo alloc] init];
    info.huiId = [dict objectForKey:@"categoryId"];
    info.huiName = [dict objectForKey:@"categoryName"];
    info.huiNameImg = [dict objectForKey:@"categoryNameUrl"];
    info.huiRate = [dict objectForKey:@"categoryRate"];
    info.huiRateImg =[dict objectForKey:@"categoryRateUrl"];
    info.huiLimit = [dict objectForKey:@"categoryLimit"];
    info.huiMoney = [dict objectForKey:@"buyAmount"];
    info.incomeMethod = [dict objectForKey:@"incomeMethod"];
    info.increaseMethod = [dict objectForKey:@"increaseMethod"];
    info.desc = [dict objectForKey:@"description"];
    return info;
}

@end


