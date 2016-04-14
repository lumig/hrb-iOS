//
//  UserInfo.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "UserInfo.h"



static UserInfo *g_userInfo;
@implementation UserInfo


+ (UserInfo *)shareUserInfo
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_userInfo = [[self alloc]init];
    });
    return g_userInfo;
}


- (id)initWithUsername:(NSString *)userName andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self.username = userName;
        self.password = password;
        
    }
    return self;
    
}

- (id)initWithUsername:(NSString *)username andPassword:(NSString *)password andIconUrl:(NSString *)iconUrl
{
    self = [super init];
    if (self) {
        
        self.username = username;
        self.password = password;
        self.iconUrl = iconUrl;
    }
    
    return self;
}
//获取本地物流信息
- (void)getLocationExpressName
{
    self.ExpressName = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExpressName"];
}
- (void)saveExpressName:(NSString *)expressName
{
    [[NSUserDefaults standardUserDefaults] setObject:expressName forKey:@"ExpressName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self getLocationExpressName];
}

- (NSString *)getExpressName
{
    NSString *str;
    str = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExpressName"];
    return str;
}

//获取送货时间信息
- (void)getLocationSendGoodsTime
{
    self.SendGoodsTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"SendGoodsTime"];
}
- (void)saveSendGoodsTime:(NSString*)sendGoodsTime
{
    [[NSUserDefaults standardUserDefaults] setObject:sendGoodsTime forKey:@"SendGoodsTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self getLocationSendGoodsTime];
}

- (NSString *)getSendGoodsTime
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"SendGoodsTime"];
    return str;
}
//获取地址对象
- (void)getLocationAddress
{
    self.addressModel = [[AddressModel alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"addressModel"]];
}
- (AddressModel *)getLocationAddressModel
{
    AddressModel *addressModel;
    addressModel = [[AddressModel alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"addressModel"]];
    
    return addressModel;
}


- (void)saveLocationAddress:(NSDictionary *)addressDic
{
    [[NSUserDefaults standardUserDefaults]setObject:addressDic forKey:@"addressModel"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self getLocationAddress];
    
    
}

//本地购物车

- (void)saveGoodsDetailDic:(NSDictionary *)goodsDic
{
    [[NSUserDefaults standardUserDefaults] setObject:goodsDic forKey:@"goodsInfo"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [self getGoodsDetail];
    //同时保存商品数组
    NSMutableArray *array = (NSMutableArray *)[self getGoodsAray];
    int index=0;
    if (array.count < 1) {
//        [self saveGoodsArray:[NSMutableArray arrayWithObjects:[[goodsDetailInfo alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"goodsInfo"]], nil]];
        [self saveGoodsArray:[NSArray arrayWithObject:goodsDic]];
    }
    else
    {
        NSMutableArray *goodsArray = [NSMutableArray arrayWithArray:array];
        int goodsCount = [[goodsDic objectForKey:@"goodsNum"] intValue];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic = [array objectAtIndex:i];
            NSNumber *goodsID = [dic objectForKey:@"goodsID"];
            NSNumber *goodsDicID = [goodsDic objectForKey:@"goodsID"];
            if ([goodsID isEqual:goodsDicID]) {
                int count =[[dic objectForKey:@"goodsNum"] intValue];
                count = goodsCount + count;
                //bug
                [dic setValue:[NSNumber numberWithInt:count] forKey:@"goodsNum"];
                [goodsArray replaceObjectAtIndex:i withObject:dic];
                
                
            }
          else
            {
                ++index;
                if (index == array.count) {
                    [goodsArray addObject:goodsDic];
                }
                
                
            }
        }
        
        NSArray *arr = [NSArray arrayWithArray:goodsArray];
        [self saveGoodsArray:arr];
    }
    
    
}

- (void)getGoodsDetail
{
//    self.goodsInfo = [[goodsDetailInfo alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"goodsInfo"]];
  
    self.goodsInfo = [goodsDetailInfo fetchWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"goodsInfo"]];
}
//- (void)getGoodsArray
//{
//    self.goodsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"goodsArray"];
//}


- (NSArray *)getGoodsAray
{
    NSArray *array = [NSArray array];
     array = [[NSUserDefaults standardUserDefaults] objectForKey:@"goodsArray"];
    
    return array;
}

- (void)saveGoodsArray:(NSArray *)array
{
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"goodsArray"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (NSMutableArray *)goodsArray
{
    if (_goodsArray == nil) {
        
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}


@end
