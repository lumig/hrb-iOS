//
//  OrderModel.m
//  hrb-iOS
//
//  Created by mac on 15/9/14.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (OrderModel *)fetchModelWithDict:(NSDictionary *)dict
{
    OrderModel *model = [[OrderModel alloc] init];
    model.consignee=[dict objectForKey:@"consignee"];
    model.detailAddress = [dict objectForKey:@"detailAddress"];
    model.mobile = [dict objectForKey:@"mobile"];
    model.orderId = [dict objectForKey:@"orderId"];
    model.orderSum = [dict objectForKey:@"orderSum"];
    model.orderWay = [dict objectForKey:@"orderWay"];
    model.orderArray = [dict objectForKey:@"pageGetPersonOrderList"];
    model.userId = [dict objectForKey:@"userId"];
    model.orderDate = dict[@""];
    model.logisticsDate = dict[@"logisticsDate"];
    model.logisticsId = dict[@"logisticsId"];
    model.orderType = dict[@"orderType"];
    return model;
}

@end
