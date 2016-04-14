//
//  AddressModel.m
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self=[super init];
    if (self)
    {
        if (dic == nil) {
            return nil;
        }
        
        self.cellPhone=[dic objectForKey:@"CellPhone"];
        self.city=[dic objectForKey:@"City"];
        self.consignee=[dic objectForKey:@"Consignee"];
        if ([dic objectForKey:@"County"]) {
            self.county=[dic objectForKey:@"County"];
            
        }else{
            self.county=@"";
        }
        self.customerDeliveryId = [dic objectForKey:@"CustomerDeliveryId"];
        if ([dic objectForKey:@"DeliveryTimeId"]) {
            self.deliveryTimeId=[dic objectForKey:@"DeliveryTimeId"];
        }
        
        self.province=[dic objectForKey:@"Province"];
        self.regionId=[dic objectForKey:@"RegionId"];
        
        if ([dic objectForKey:@"Street"]) {
            self.street=[dic objectForKey:@"Street"];
        }
        
        self.address = [dic objectForKey:@"address"];
    }
    
    return self;
}

@end



