//
//  ProjectProgressingModel.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectProgressingModel.h"
#import "AFNetworking.h"

#define urlString  [NSString stringWithFormat:@"http://app.dajunbank.com/index.php/Index/ProMarch"]


@implementation ProjectProgressingModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)getProjectProgressingDataWithProjectID:(NSString *)projectID andPage:(NSNumber *)page andProjectProgressingBlock:(ProjectProgressingBlock)projectProgressingBlock
{
    [_dataArray removeAllObjects];
    NSDictionary *parameters = @{@"projectid":projectID, @"page":page};
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (projectProgressingBlock) {
            projectProgressingBlock(NO,nil);
        }
        
        [_dataArray removeAllObjects];
        NSLog(@"error:%@",[error localizedDescription]);
    }];
}
@end
