//
//  AddressModel.h
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property(nonatomic,strong)NSString *cellPhone;
@property(nonatomic,strong)NSString *city;
//收货人
@property(nonatomic,strong)NSString *consignee;
//地址
@property(nonatomic,strong)NSString *address;

@property(nonatomic,strong)NSString *county;
@property(nonatomic,strong)NSNumber *customerDeliveryId;
@property(nonatomic,strong)NSString *deliveryTimeId;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *regionId;
@property(nonatomic,strong)NSString *street;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
