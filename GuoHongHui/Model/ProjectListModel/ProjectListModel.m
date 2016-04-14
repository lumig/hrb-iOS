//
//  ProjectListModel.m
//  GuoHongHui
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectListModel.h"

@implementation ProjectListModel

-(instancetype)init
{
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)getProjectListDataWithView:(UIView *)view ProjectListBlock:(ProjectListBlock)projectListBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"project/listProject");
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
               [ _dataArray addObject:[ProjectListInfo fetchProjectListInfoWithDict:dict]];
            }
            
            if (projectListBlock) {
                projectListBlock(YES,_dataArray);
            }
            else
            {
                projectListBlock(NO,nil);
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if (projectListBlock) {
            projectListBlock(NO,nil);
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
