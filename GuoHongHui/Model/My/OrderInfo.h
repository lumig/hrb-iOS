//
//  OrderInfo.h
//  GuoHongHui
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//订单信息

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject

@property(nonatomic,strong)NSString *orderID;

@property(nonatomic,strong)NSNumber *goodsNum;

@property(nonatomic,strong)NSNumber *orderTotalNum;

@property(nonatomic,strong)NSArray *imgArray;

@end
