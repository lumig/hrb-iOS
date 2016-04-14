//
//  HuiRongBaoModel.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/18.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiRongBaoModel.h"

@implementation HuiRongBaoModel

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)getHuirongbaoDataWithView:(UIView *)view HuirongbaoBlock:(HuirongbaoBlock)huirongbaoBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"category/listCategory");
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    [mangager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"responseObject%@",responseObject);
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSArray *array = [NSArray arrayWithArray:responseObject];
            for (NSDictionary *dict in array) {
                [_dataArray addObject:[HuiRongBaoInfo fetchInfoWithDict:dict]];
            }
        }
        
        
            if (huirongbaoBlock) {
                huirongbaoBlock(YES,_dataArray);
            }
            else
            {
                huirongbaoBlock(NO,nil);
            }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if (huirongbaoBlock) {
            huirongbaoBlock(NO,nil);
        
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
