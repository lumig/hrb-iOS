//
//  HuiWorldModel.m
//  GuoHongHui
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiWorldModel.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "goodsDetailInfo.h"
@implementation HuiWorldModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)getHuiWorldDataWithView:(UIView *)view HuiWorldBlock:(HuiWorldBlock)huiWorldBlock failureBlock:(FailureBlock)failureBlock
{
    
    [_dataDict removeAllObjects];
    NSString *urlStr = urlStr(@"product/listPageProduct");
    
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"responseObject%@",responseObject);
        
         NSArray *keyArray = [responseObject allKeys];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            for (NSString *str in keyArray) {
                if ([str isEqualToString:@"topPic"]) {
                    
//                    [_dataArray addObject:[responseObject objectForKey:@"imageUrl"]];
                    NSMutableArray *array = [NSMutableArray array];
                    NSString *str = @"";
                    for (NSDictionary *dict in [responseObject objectForKey:@"topPic"]) {
                        str = [dict objectForKey:@"imageUrl"];
                        [array addObject:str];
                    }
                    
//                    [_dataArray addObject:@{@"imageUrl":array}];
                    [_dataDict  setObject:array forKey:@"imageUrl"];
                }
                
                if ([str isEqualToString:@"products"]) {
                    NSMutableArray *goodsArray = [NSMutableArray array];
                    for (NSDictionary *dict in [responseObject objectForKey:@"products"]) {
                        
                        [goodsArray addObject:[goodsDetailInfo fetchWithDictionary:dict]];
                    }
//                    [_dataArray addObject:@{@"goodsArray":goodsArray}];
                    [_dataDict setObject:goodsArray forKey:@"goodsArray"];
                }
                
            }
        }
        
        
        if (huiWorldBlock) {
            huiWorldBlock(YES,_dataDict);
        }
        else
        {
            huiWorldBlock(NO,nil);
        }
        
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
     
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        
        if (huiWorldBlock) {
            huiWorldBlock(NO,nil);
        }
        if (failureBlock) {
            failureBlock(YES);
        }
        else
        {
            failureBlock(NO);
        }
        NSLog(@"error:%@",[error localizedDescription]);
        
        
    }];
}

@end
