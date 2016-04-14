//
//  productModel.h
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface productModel : NSObject

@property(nonatomic,strong)NSString *productName;
@property(nonatomic,strong)NSString *purchaseDate;
@property(nonatomic,strong)NSString *earningDate;
//本金

@property(nonatomic,strong)NSNumber *principal;
//利率
@property(nonatomic,strong)NSNumber *rate;
//利息
@property(nonatomic,strong)NSNumber *interest;

//投资总额
@property(nonatomic,strong)NSNumber *totalInvestment;
//已收款总额
@property(nonatomic,strong)NSNumber *earningTotal;
//待收款总额
@property(nonatomic,strong)NSNumber *holdingTotal;

+ (productModel *)fetchWithDict:(NSDictionary *)dict;

+ (NSString *)changeWithArray:(NSArray *)array;

+ (productModel *)fetchWithOnlyDict:(NSDictionary *)dict;

@end
