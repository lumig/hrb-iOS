//
//  HomeModel.m
//  GuoHongHui
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)getDataWithView:(UIView *)view successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    
    [_dataDict removeAllObjects];
    NSString *urlStr = urlStr(@"homepage/listHomepage");
    
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
//        NSLog(@"responseObject%@",responseObject);
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dataDict = [responseObject mutableCopy];
        }
        NSArray *keyArray = [dataDict allKeys];
        
        for (NSString *str in keyArray) {
            
            NSMutableArray *newsArray = [NSMutableArray array];
            NSMutableArray *goodsArray = [NSMutableArray array];
            if ([str isEqualToString:@"listpagenews"]) {
                NSArray *array = [NSArray array];
                array = [[dataDict objectForKey:@"listpagenews"] mutableCopy];
                for (NSDictionary *dict in array) {
                    
                    [newsArray addObject:[LastestNewsModel fetchWithLastestNewsDict:dict]];
                }
                 [_dataDict setObject:newsArray forKey:@"news"];
            }
           
            
            if ([str isEqualToString:@"listproducts"]) {
                NSArray *array = [NSArray array];
               array = [[dataDict objectForKey:@"listproducts"] mutableCopy];
               for (NSDictionary *dict in array) {
                   
                   [goodsArray addObject:[goodsDetailInfo fetchWithDictionary:dict]];
               }
                [_dataDict setObject:goodsArray forKey:@"goods"];
            }
            
            
            if ([str isEqualToString:@"hometoppic"]) {
                NSArray *array = [NSArray arrayWithArray:[dataDict objectForKey:@"hometoppic"]];
                
                [_dataDict setObject:array forKey:@"addsUrl"];
            }
            NSMutableArray *textArray = [NSMutableArray array];
            if ([str isEqualToString:@"url"]) {
                NSArray *array = [NSArray array];
                 array = [[dataDict objectForKey:@"url"] mutableCopy];
                for (NSDictionary *dict in array) {
                    NSString *str = [dict objectForKey:@"messageUrl"];
                    [textArray addObject:str];
                }
                [_dataDict setObject:textArray forKey:@"text"];
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
