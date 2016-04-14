//
//  BuyDateModel.h
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyDateModel : NSObject

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSNumber *huiCode;
@property(nonatomic,strong)NSNumber *amountStr;
@property(nonatomic,strong)NSString *buyDate;
@property(nonatomic,strong)NSString *type;

+ (BuyDateModel *)fetchWithDict:(NSDictionary *)dict;

+ (NSString *)replaceWithString:(NSString *)idCard;
+ (NSString *)changeWithArray:(NSArray *)array;
@end
