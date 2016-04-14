//
//  UserMessageDataBase.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/11.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDBManager.h"
#import "UserInfo.h"


@interface UserMessageDataBase : NSObject

@property(nonatomic,strong)FMDatabase *db;

+(UserMessageDataBase *)shareUserMessageDataBase;

- (void)createUserMessageDataBase;

- (void)addUserMessage:(UserInfo *)info;

- (void)updataUserMessageWithUser:(UserInfo *)info;

- (UserInfo *)findUserMessageWithUsername:(NSString *)username;

//商品列表

//- (void)createGoodsDataBase;
//- (void)addGoodsDataWithusername:(NSString *)username andGoodsID:(NSString *)goodsID andimgStr:(NSString *)imgStr andisSelected:(BOOL)isSelected andGoodsTitle:(NSString *)goodsTitle andhuiPrice:(NSString *)huiPrice andGoodsNum:(NSString *)goodsNum;

//- (void)getGoodsDataWithUsername:(NSString *)username;

@end
