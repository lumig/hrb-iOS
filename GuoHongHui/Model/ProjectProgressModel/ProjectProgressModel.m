//
//  ProjectProgressModel.m
//  GuoHongHui
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectProgressModel.h"
#import "ProjectProgressInfo.h"
@implementation ProjectProgressModel
- (instancetype)init
{
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)getProjectProgressDataWithView:(UIView *)view andProjectId:(NSNumber *)projectID ProjectProgressBlock:(ProjectProgressBlock)projectProgressBlock failureBlock:(FailureBlock)failureBlock
{
    
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"project/listProjectPhase");
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    NSDictionary *para = @{@"projectId":projectID};
    
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"responseObject%@",responseObject);
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDict = [responseObject mutableCopy];
            NSArray *keyArray = [responseObject allKeys];
            NSDictionary *projectDict = [NSDictionary dictionary];
            for (NSString *str in keyArray) {
                
                if ([str isEqualToString:@"project"]) {
                    projectDict = [responseObject[@"project"] mutableCopy];
                }
                
                if ([str isEqualToString:@"listphaseShowDetail"]) {
                    NSArray *array = [responseObject objectForKey:@"listphaseShowDetail"];
                    NSMutableDictionary *phaseDict = [NSMutableDictionary dictionary];
                    for (NSDictionary *dic in array) {
                        [phaseDict setObject:[dic objectForKey:@"phaseDate"] forKey:@"phaseDate"];
                        [phaseDict setObject:[dic objectForKey:@"phaseDetail"] forKey:@"phaseDetail"];
                        NSArray *imgArray = [dic objectForKey:@"picUrl"];
                        NSMutableArray *imgArr = [NSMutableArray array];
                        for (NSDictionary *imgDic in imgArray) {
                            [imgArr addObject:[imgDic objectForKey:@"imageUrl"]];
                        }
                        [phaseDict setObject:imgArr forKey:@"imgArray"];
                        [phaseDict setObject:projectDict[@"projectTitle"] forKey:@"projectTitle"];
                        [phaseDict setObject:projectDict[@"projectUrl"] forKey:@"projectUrl"];
                        [phaseDict setObject:projectDict[@"projectId"] forKey:@"projectId"];
                        [phaseDict addEntriesFromDictionary:dataDict];
                        [_dataArray addObject:[ProjectProgressInfo fetchWithProjectProgressDict:phaseDict]];
                    }
                }
                
            }
        }
        
        if (projectProgressBlock) {
            projectProgressBlock(YES,_dataArray);
        }
        else
        {
            projectProgressBlock(NO,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if (projectProgressBlock) {
            projectProgressBlock(NO,nil);
        }
        
        if (failureBlock) {
            failureBlock(YES);
        }else
        {
            failureBlock(NO);
        }
        NSLog(@"error:%@",[error localizedDescription]);
        
    }];
}

@end
