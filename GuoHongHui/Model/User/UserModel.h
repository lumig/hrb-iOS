//
//  UserModel.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UserBlock)(BOOL state, NSDictionary *dataDict);
@interface UserModel : NSObject
@property(nonatomic,strong)NSDictionary *data;

//登录
- (void)getUserDataWithPhone:(NSString *)phone andPassword:(NSString *)password andUserBlock:(UserBlock)userBlock;

@end
