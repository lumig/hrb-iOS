//
//  HuiRongBaoInfo.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/18.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuiRongBaoInfo : NSObject
@property(nonatomic,strong)NSNumber *huiId;
@property(nonatomic,strong)NSString *huiName;
@property(nonatomic,strong)NSString *huiNameImg;
@property(nonatomic,strong)NSNumber *huiRate;
@property(nonatomic,strong)NSString *huiRateImg;
@property(nonatomic,strong)NSNumber *huiLimit;
@property(nonatomic,strong)NSNumber *huiMoney;
@property(nonatomic,strong)NSString *incomeMethod;
@property(nonatomic,strong)NSString *increaseMethod;
@property(nonatomic,strong)NSString *desc;

+(HuiRongBaoInfo *)fetchInfoWithDict:(NSDictionary *)dict;


@end
