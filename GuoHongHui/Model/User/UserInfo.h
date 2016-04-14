//
//  UserInfo.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

#import "goodsDetailInfo.h"

@interface UserInfo : NSObject


//__kDWAllModel(username);
//__kDWAllModel(password);

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *iconUrl;

@property(strong,nonatomic)NSString *ExpressName;

@property(strong,nonatomic)NSString *SendGoodsTime;

@property(strong,nonatomic)AddressModel *addressModel;

@property(nonatomic,strong)NSMutableArray *goodsArray;

@property(nonatomic,strong)goodsDetailInfo *goodsInfo;

//@property(nonatomic,strong)NSString *address;

+ (UserInfo *)shareUserInfo;

- (id)initWithUsername:(NSString *)userName andPassword:(NSString *)password;

- (id)initWithUsername:(NSString *)username andPassword:(NSString *)password andIconUrl:(NSString *)iconUrl;

- (void)getLocationAddress;
- (AddressModel *)getLocationAddressModel;
- (void)saveLocationAddress:(NSDictionary *)addressDic;

//获取本地物流信息
- (void)getLocationExpressName;
- (void)saveExpressName:(NSString *)expressName;
- (NSString *)getExpressName;

//获取送货时间信息
- (void)getLocationSendGoodsTime;

- (void)saveSendGoodsTime:(NSString*)sendGoodsTime;
- (NSString *)getSendGoodsTime;

//保存本地购物车商品列表

- (void)saveGoodsDetailDic:(NSDictionary *)goodsDic;
- (void)getGoodsDetail;
//- (goodsDetailInfo *)getGoodsDetailInfo;


//保存商品数组
- (void)saveGoodsArray:(NSArray *)array;
- (NSArray * )getGoodsAray;
//- (void)getGoodsArray;
@end
