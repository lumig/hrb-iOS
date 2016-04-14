//
//  BuyDateModel.m
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BuyDateModel.h"

@implementation BuyDateModel

+ (BuyDateModel *)fetchWithDict:(NSDictionary *)dict
{
    BuyDateModel *model = [[BuyDateModel alloc] init];
    model.userName = [BuyDateModel replaceWithString:[dict objectForKey:@"mobile"]];
    model.huiCode = [dict objectForKey:@"huijinCount"];
    model.buyDate = [BuyDateModel changeWithArray:[dict objectForKey:@"date"]];
    
    return model;
}

+ (NSString *)replaceWithString:(NSString *)idCard
{
    NSString *str;
    
    NSRange range = NSMakeRange(3,4);
    str = [idCard stringByReplacingCharactersInRange:range withString:@"****"];
    return str;
    
}

+ (NSString *)changeWithArray:(NSArray *)array
{
    NSString *str = @"";
    NSString *inter;
    for (int i = 0; i < array.count; ++i) {
        inter = array[i];
        str= [str stringByAppendingString:[NSString stringWithFormat:@"%@-",inter]];
    }
    NSRange range = NSMakeRange(0, str.length - 1);
    
    str = [str substringWithRange:range];
    return str;
}


@end
