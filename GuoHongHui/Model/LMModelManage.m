//
//  LMModelManage.m
//  GuoHongHui
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "LMModelManage.h"
#import "productModel.h"
#import "NSDictionary+LifeExtension.h"
#import "OrderModel.h"
#import "investorRecordModel.h"

@implementation LMModelManage
static LMModelManage *g_LMModelManage;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
        _dataDict = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (LMModelManage *)shareLLModelManage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_LMModelManage = [[self alloc] init];
    });
    return g_LMModelManage;
}

#pragma mark --
#pragma mark -- 预计待收益
- (void)getHoldingDataWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock)sucessBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"investrecord/expectTitle");
    
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    NSDictionary *para = @{@"idcard":idCard};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject%@",responseObject);
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
             }
        
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *dataArray = [NSArray arrayWithArray:responseObject];
                for (NSDictionary *dict in dataArray) {
                    [_dataArray addObject:[productModel fetchWithDict:dict]];
                }
            }
        
        if (sucessBlock) {
            sucessBlock(YES,_dataArray);
        }
        else
        {
            sucessBlock(NO,nil);
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

#pragma mark - 已收益
- (void)getHavingEarnedDataWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock)sucessBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"investrecord/findoverdueByidcard");
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    NSDictionary *para = @{@"idcard":idCard};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject%@",responseObject);
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *dataArray = [NSArray arrayWithArray:responseObject];
            for (NSDictionary *dict in dataArray) {
                [_dataArray addObject:[productModel fetchWithOnlyDict:dict]];
            }
        }
        
        if (sucessBlock) {
            sucessBlock(YES,_dataArray);
        }
        else
        {
            sucessBlock(NO,nil);
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

- (void)getRecommandDataWithView:(UIView *)view sucessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"person/recommendCategory");
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
        
        
        if (successBlock) {
            successBlock(YES,_dataArray);
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
        
        if (successBlock) {
            successBlock(NO,nil);
            
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

- (void)getSignInDataWithView:(UIView *)view userId:(NSString *)userId successfulBlock:(SuccessfulBlock)successfulBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataDict removeAllObjects];
    NSString *urlStr = urlStr(@"registration/singIn");
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    NSDictionary *para = @{@"userId":userId};
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:responseObject];
            
            NSArray *keyArray = [dataDict allKeys];
            
           
            for (NSString *str in keyArray) {
                
                if ([str isEqualToString:@"isregistration"]) {
                    [_dataDict setObject:[dataDict objectForKey:@"isregistration"] forKey:@"isSignIn"];
                }
                
                if ([str isEqualToString:@"huijinCount"]) {
                    [_dataDict setObject:[dataDict objectForKey:@"huijinCount"] forKey:@"huiCode"];
                }
                 NSMutableArray *signInArray = [NSMutableArray array];
                if ([str isEqualToString:@"signin"]) {
                    NSArray *array = [dataDict objectForKey:@"signin"];
                    for (NSDictionary *dict in array) {
                        [signInArray addObject:[SignInModel fetchWithDict:dict]];
                    }
                    [_dataDict setObject:signInArray forKey:@"signIn"];
                }
            }
        }
        
        if (successfulBlock) {
            successfulBlock(YES,_dataDict);
        }
        else
        {
            successfulBlock(NO,nil);
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

- (void)getMyEarningDataWithView:(UIView *)view idCard:(NSString *)idCard successfulBlock:(SuccessfulBlock)successfulBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataDict removeAllObjects];
    if (idCard == nil) {
        return;
    }
    NSString *urlStr = urlStr(@"investrecord/expectTitle");

    BOOL showHud = view !=nil;
    NSDictionary *para = @{@"idcard":idCard};
   
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
//    mangager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mangager POST:urlStr parameters:para  success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"magi %@",responseObject);
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *array = [responseObject mutableCopy];
            CGFloat count = 0;
            for (NSDictionary *dict in array) {
                count +=[dict[@"sum"] floatValue];
            }
            [_dataDict setObject:[NSNumber numberWithFloat:count] forKey:@"amount"];
//            _dataDict = responseObject;
        }
        if (successfulBlock) {
            successfulBlock(YES,_dataDict);
        }
        else
        {
            successfulBlock(NO,nil);
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
        
        NSLog(@"error:%@",[error description]);
    }];

    }


- (void)getInvestRecordDataWithView:(UIView *)view idCard:(NSString *)idCard successBlcok:(SuccessfulBlock)successfulBlock failureBlock:( FailureBlock )failureBlock
{
    [_dataDict removeAllObjects];
    NSString *urlStr = urlStr(@"investrecord/list");
    BOOL showHud = view !=nil;
    NSDictionary *para = @{@"idcard":idCard};
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
//    [req setHTTPMethod:@"POST"];
//    [req setCachePolicy:NSURLRequestUseProtocolCachePolicy];
//    
//    NSString *json= [para toJSONDescription];
//    [req setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    AFHTTPRequestOperation *op= [[AFHTTPRequestOperation alloc] initWithRequest:req];
//    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
//    serializer.removesKeysWithNullValues=YES;
//    op.responseSerializer=serializer;
//    
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:responseObject];
            NSArray *keyArray = [dict allKeys];
            NSMutableArray *holdingArray = [NSMutableArray array];
            for (NSString *str in keyArray) {
                if ([str isEqualToString:@"expectList"]) {
//                    NSArray *array = [NSArray array];
//                    array = [dict objectForKey:@"expectidcardList"];
                    for (NSDictionary *dic in [dict objectForKey:@"expectList"]) {
                        [holdingArray addObject:[productModel fetchWithDict:dic]];
                    }
                   
                    [_dataDict setValue:holdingArray forKey:@"holdingValue"];
                    
                }
                NSMutableArray *earnedArray = [NSMutableArray array];
                if ([str isEqualToString:@"overdueList"]) {
//                    NSArray *array = [NSArray array];
//                    array = [dict objectForKey:@"overdueidcardList"];
                    for (NSDictionary *dic in [dict objectForKey:@"overdueList"]) {
                        [earnedArray addObject:[productModel fetchWithDict:dic]];
                    }
                    [_dataDict setValue:earnedArray forKey:@"earnedValue"];
                }
            }
            if (successfulBlock) {
                successfulBlock(YES,_dataDict);
            }
            else
                
            {
                successfulBlock(NO,nil);
            }
            
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
        
        NSLog(@"error:%@",[error description]);
        
    }];
}


- (void)getBuyRecordDataWithView:(UIView *)view goodsId:(NSNumber *)goodsId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"purchaseRecord/list");
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    NSDictionary *para = @{@"productId":goodsId};
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *array = [NSArray arrayWithArray:responseObject];
            for (NSDictionary *dict in array) {
                [_dataArray addObject:[BuyDateModel fetchWithDict:dict]];
            }
        }
        
        if (successBlock) {
            successBlock(YES,_dataArray);
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
        
        NSLog(@"error:%@",[error description]);
    }];
}

- (void)getCalendarDataWithView:(UIView *)view idCard:(NSString *)idCard successfulBlock:(SuccessfulBlock)successfulBlock failureBlock:(FailureBlock)failureBlock
{
    
    [_dataDict removeAllObjects];
    NSString *urlStr = urlStr(@"receipt");
    BOOL showHud = view !=nil;
    NSDictionary *para = @{@"idcard":idCard};
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
//        NSLog(@"reponse%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            _dataDict = [responseObject mutableCopy];
        }
        if (successfulBlock) {
            successfulBlock(YES,_dataDict);
        }
        else
        {
            successfulBlock(NO,_dataDict);
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
        
        NSLog(@"error:%@",[error description]);
    }];

}

- (void)getOrderDataWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    //person/getPersonOrder
    NSString *urlStr = urlStr(@"person/getReadyOrder");
    BOOL showHud = view !=nil;
    NSDictionary *para = @{@"idcard":idCard};
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        NSArray *array = [NSArray array];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            array = [responseObject mutableCopy];

            }
        for (NSDictionary *dict in array) {
            NSArray *dataArray =dict[@"pageGetPersonOrderList"];
            if (dataArray.count < 1) {
                
            }
            else
            {
            [_dataArray addObject:[OrderModel fetchModelWithDict:dict]];
            }
        }
        
        if (successBlock) {
            successBlock(YES,_dataArray);
        }else
        {
            successBlock(NO,_dataArray);
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
        
        NSLog(@"error:%@",[error description]);
    }];

    
}

- (void)getShippedOrderWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"person/getShippedOrder");
    BOOL showHud = view !=nil;
    NSDictionary *para = @{@"idcard":idCard};
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        NSArray *array = [NSArray array];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            array = [responseObject mutableCopy];
            
        }
        for (NSDictionary *dict in array) {
            NSArray *dataArray =dict[@"pageGetPersonOrderList"];
            if (dataArray.count < 1) {
                
            }
            else
            {
                [_dataArray addObject:[OrderModel fetchModelWithDict:dict]];
            }
        }
        
        if (successBlock) {
            successBlock(YES,_dataArray);
        }else
        {
            successBlock(NO,_dataArray);
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
        
        NSLog(@"error:%@",[error description]);
    }];

}

- (void)getReceivedOrderWithView:(UIView *)view idCard:(NSString *)idCard successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"person/getReceivedOrder");
    BOOL showHud = view !=nil;
    NSDictionary *para = @{@"idcard":idCard};
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        NSArray *array = [NSArray array];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            array = [responseObject mutableCopy];
            
        }
        for (NSDictionary *dict in array) {
            NSArray *dataArray =dict[@"pageGetPersonOrderList"];
            if (dataArray.count < 1) {
                
            }
            else
            {
                [_dataArray addObject:[OrderModel fetchModelWithDict:dict]];
            }
        }
        
        if (successBlock) {
            successBlock(YES,_dataArray);
        }else
        {
            successBlock(NO,_dataArray);
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
        
        NSLog(@"error:%@",[error description]);
    }];

}

- (void)getHuiRecordWithCategoryId:(NSNumber *)categoryId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    [_dataArray removeAllObjects];
    NSString *urlStr = urlStr(@"category/listRecommend");
    NSDictionary *para = @{@"categoryId":categoryId};
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *dataArray = [responseObject mutableCopy];
            for (NSDictionary *dict in dataArray) {
                [_dataArray addObject:[investorRecordModel fetchWithDict:dict]];
            }
        }
        
        if (successBlock) {
            successBlock(YES,_dataArray);
        }
        else
        {
            successBlock(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock) {
            failureBlock(YES);
        }
        else
        {
            failureBlock(NO);
        }
    }];
}

- (void)upLoadWithUserFace:(UIImage *)faceImage idCard:(NSString *)idCard faceBlock:(void (^)(BOOL, NSString *))faceBlock
{
    if (faceImage == nil || [idCard length] == 0)
    {
        if (faceBlock) {
            faceBlock(NO,nil);
        }
        return;
    }
    NSString *urlStr = urlStr(@"uploadFile");
//    NSDictionary *parameters = @{@"idcard":idCard};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         NSData *imageData = UIImageJPEGRepresentation(faceImage, 0.6);
         
         [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@_1.jpg",idCard] mimeType:@"image/jpeg"];
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"responseObject %@",responseObject);
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             
             NSDictionary *responseDic = (NSDictionary *)responseObject;
             
             if ([responseDic objectForKey:@"uploadFile"] !=nil)
             {
                 NSString *imageUrl = [responseDic objectForKey:@"uploadFile"];

                 
                 if (faceBlock)
                 {
                     faceBlock(YES,imageUrl);
                 }
                 
                 return ;
             }
         }
         
         if (faceBlock) {
             faceBlock(NO,nil);
         }
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if (faceBlock)
         {
             faceBlock(NO,nil);
         }
         NSLog(@"error %@",error);
     }];

}

@end

