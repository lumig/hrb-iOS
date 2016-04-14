//
//  UserModel.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "UserModel.h"
#import "AFNetworking.h"
#define urlString     [NSString stringWithFormat:@"http://app.dajunbank.com/index.php/Index/Login"]

@implementation UserModel



- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = [NSDictionary dictionary];
    }
    return self;
}

- (void)getUserDataWithPhone:(NSString *)phone andPassword:(NSString *)password andUserBlock:(UserBlock)userBlock
{
    
    NSString *urlStr = urlStr(@"user/loginIn");
    NSDictionary *parameters = @{@"mobile":phone, @"password":password};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        
        if (userBlock) {
            userBlock(YES,dict);
        }
        
        else
        {
            userBlock(NO,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (userBlock) {
            userBlock(NO,nil);
        }
    }];
}

@end
