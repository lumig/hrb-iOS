//
//  OrderModel.h
//  hrb-iOS
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(nonatomic,strong)NSString *consignee;
@property(nonatomic,strong)NSString *detailAddress;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSNumber *orderSum;
@property(nonatomic,strong)NSString *orderWay;
@property(nonatomic,strong)NSArray *orderArray;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *orderDate;
@property(nonatomic,strong)NSString *logisticsId;
@property(nonatomic,strong)NSString *logisticsDate;
@property(nonatomic,strong)NSString *orderType;

+(OrderModel *)fetchModelWithDict:(NSDictionary *)dict;

@end
