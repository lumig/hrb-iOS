//
//  investorRecordModel.h
//  GuoHongHui
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface investorRecordModel : NSObject

@property(nonatomic,strong)NSString *investor;
@property(nonatomic,strong)NSNumber *amountMoney;
@property(nonatomic,strong)NSString *recordStr;
@property(nonatomic,strong)NSString *type;

+ (investorRecordModel *)fetchWithDict:(NSDictionary *)dict;
+ (NSString *)replaceWithString:(NSString *)idCard;
+ (NSString *)changeWithArray:(NSArray *)array;

@end
