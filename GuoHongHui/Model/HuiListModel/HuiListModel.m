//
//  HuiListModel.m
//  GuoHongHui
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiListModel.h"
#import "investorRecordModel.h"

@implementation HuiListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)getDataWithView:(UIView *)view categoryId:(NSString *)huiId successBlock:(HuiListBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    [_dataDict removeAllObjects];
    NSString *urlStr = urlStr(@"category/pageCategory");
    BOOL showHud = view !=nil;
    NSDictionary *para = @{@"categoryId":huiId};
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject%@",responseObject);
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:responseObject];
            NSArray *keyArray = [responseObject allKeys];
            for (NSString *str in keyArray) {
                if ([str isEqualToString:@"categorydetail"]) {
                    NSDictionary *dict = [dataDict objectForKey:@"categorydetail"];
                    [_dataDict setValue:[HuiRongBaoInfo fetchInfoWithDict:dict] forKey:@"product"];
                }
                NSMutableArray *recordArray = [NSMutableArray array];
                if ([str isEqualToString:@"listinvestrecord"]) {
                    recordArray = [dataDict objectForKey:@"listinvestrecord"];
                    for (NSDictionary *dict in recordArray) {
                        [recordArray addObject:[investorRecordModel fetchWithDict:dict]];
                    }
                }
                [_dataDict setValue:recordArray forKey:@"record"];
            }
        }
        
        if (successBlock) {
            successBlock(YES,_dataDict);
        }
        else
        {
            successBlock(NO,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
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
