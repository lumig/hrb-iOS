//
//  OrderViewController.h
//  hrb-iOS
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderViewController : BaseViewController
@property(nonatomic,strong)NSArray *goodsArray;
@property(nonatomic,strong)NSString *allPrice;

@property(nonatomic,strong)NSString *logisticsId;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *typeStr;

@end
