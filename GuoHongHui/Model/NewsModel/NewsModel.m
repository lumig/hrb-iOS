//
//  NewsModel.m
//  GuoHongHui
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)getNewsDataWithView:(UIView *)view NewsBlock:(NewsBlock)newsBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"news/listNews");
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
            
            NSArray *array = [NSArray arrayWithArray:responseObject ];
            
            for (NSDictionary *dict in array) {
                [_dataArray addObject:[LastestNewsModel fetchWithLastestNewsDict:dict]];
            }
            
            if (newsBlock) {
                newsBlock(YES,_dataArray);
            }
            else
            {
                newsBlock(NO,nil);
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if (newsBlock) {
            newsBlock(NO,nil);
        
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
