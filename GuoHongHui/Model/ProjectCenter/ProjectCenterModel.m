//
//  ProjectCenterModel.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectCenterModel.h"
#import "AFNetworking.h"

#define urlString  [NSString stringWithFormat:@"http://app.dajunbank.com/index.php/Index/ProjectList"]

@implementation ProjectCenterModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [NSMutableArray array];
    }
    return self;
}

- (void)getProjectDataWithView:(UIView *)view andProjectCenterBlock:(ProjectCenterBlock)projectCenterBlock andFailureBlock:(FailureBlock)failureBlock
{
    [_dataArr removeAllObjects];
    NSString *urlStr = urlStr(@"project/listProject");
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *dataArray = [responseObject mutableCopy];
            for (NSDictionary *dict in dataArray) {
                [_dataArr addObject:[ProjectListInfo fetchProjectListInfoWithDict:dict]];
            }
        }
        if (projectCenterBlock) {
            projectCenterBlock(YES,_dataArr);
        }
        else
        {
            projectCenterBlock(NO,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (projectCenterBlock) {
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
        }
    }];
}

- (void)getProjectCenterDataWithPage:(NSNumber *)page andProjectCenterBlock:(ProjectCenterBlock)projectCenterBlock
{
    [_dataArr removeAllObjects];
    NSString *urlStr = urlStr(@"project/listProject");
    NSDictionary *prameters = @{@"page":page};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:prameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"magi%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (projectCenterBlock) {
            projectCenterBlock(NO,nil);
        }
        NSLog(@"error:%@",[error localizedDescription]);
    }];
}

- (void)getMoreDataProjectCenterWithMemberID:(NSString *)memberID andPage:(NSNumber *)page andProjectCenterBlock:(ProjectCenterBlock)projectCenterBlock
{
//    NSDictionary *parameters = @{@"memberid":memberID, @"page":page};
    
}


@end
