//
//  investorRecordModel.m
//  GuoHongHui
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "investorRecordModel.h"

@implementation investorRecordModel

+ (investorRecordModel *)fetchWithDict:(NSDictionary *)dict
{
    investorRecordModel *model = [[investorRecordModel alloc] init];
    
    model.investor = [investorRecordModel replaceWithString:[dict objectForKey:@"idcard"]];
    model.amountMoney = [dict objectForKey:@"investmentVolume"];
    model.recordStr = [investorRecordModel changeWithArray:[dict objectForKey:@"investmentDate"]];
    
    return model;
}


+ (NSString *)replaceWithString:(NSString *)idCard
{
    NSString *str;
    NSRange range = NSMakeRange(4, 10);
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
