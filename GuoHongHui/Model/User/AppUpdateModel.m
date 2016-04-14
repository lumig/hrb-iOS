//
//  AppUpdateModel.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "AppUpdateModel.h"
#import "AFNetworking.h"

#define urlStr     [NSString stringWithFormat:@"http://app.dajunbank.com/index.php/Index/applist"]

@implementation AppUpdateModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return self;
}

#warning 更新接口没有
- (void)getUpdateMessageWithUpdateBlock:(UpdateBlock)updateBlock
{
    [_dataDict removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"magi%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        _dataDict = [dic mutableCopy];
        
        if (updateBlock) {
            updateBlock(YES,_dataDict);
        }
        else
        {
            updateBlock(NO,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (updateBlock) {
            
            updateBlock(NO,nil);
        }
    }];
}


@end
