//
//  GoodsDetailModel.m
//  GuoHongHui
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "GoodsDetailModel.h"
#import <AFNetworking.h>
#import "goodsDetailInfo.h"

@implementation GoodsDetailModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        _goodsInfo = [[goodsDetailInfo alloc] init];
    }
    return self;
}

- (void)getGoodsDetailDataWithView:(UIView *)view andproductId:(NSNumber *)productID GoodsDetailBlock:(GoodsDetailBlock)goodsDetailBlock failureBlock:(FailureBlock)failureBlock
{
    
    NSString *urlStr = urlStr(@"product/pageProductDetail");
    
    BOOL showHud = view !=nil;
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
    AFHTTPRequestOperationManager *mangager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *para = @{@"productId":productID};
    
    [mangager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"responseObject%@",responseObject);
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *keyArray = [responseObject allKeys];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            for (NSString *str in keyArray) {
                if ([str isEqualToString:@"product"]) {
                    NSDictionary *proDict = [responseObject objectForKey:@"product"];
                    NSArray *proAllKeys = [proDict allKeys];
                    for (NSString *string in proAllKeys) {
                        if ([string isEqualToString:@"productId"]) {
                            
                            [dict setObject:[proDict objectForKey:@"productId"]
                                     forKey:@"productId"];
                        }
                        if ([string isEqualToString:@"productDetail"]) {
                            [dict setObject:[proDict objectForKey:@"productDetail"] forKey:@"productDetail"];
                        }
                        if ([string isEqualToString:@"productName"]) {
                            [dict setObject:[proDict objectForKey:@"productName"] forKey:@"productName"];
                        }
                        if ([string isEqualToString:@"productPrice"]) {
                            
                            [dict setObject:[proDict objectForKey:@"productPrice"] forKey:@"productPrice"];
                        }
                        if ([string isEqualToString:@"productCount"]) {
                            
                            [dict setObject:[proDict objectForKey:@"productCount"] forKey:@"productCount"];
                        }
                    }
                }
                NSMutableArray *imageArray = [NSMutableArray array];
                if ([str isEqualToString:@"productPic"]) {
                    
                    NSArray *arr = [responseObject objectForKey:@"productPic"];
                    
                    for (NSDictionary *dic in arr) {
                        [imageArray addObject:[dic objectForKey:@"imageUrl"]];
                    }
                }
                
                [dict setObject:imageArray forKey:@"imgArray"];
                
                NSMutableArray *descPicArray = [NSMutableArray array];
                if ([str isEqualToString:@"productdesc"]) {
                    
                    NSArray *array = [responseObject objectForKey:@"productdesc"];
                    
                    for (NSDictionary *dic in array) {
                        
                        NSMutableDictionary *descDic = [NSMutableDictionary dictionary];
                        [descDic setObject:[dic objectForKey:@"photoDecription"] forKey:@"imageDesc"];
                        [descDic setObject:[dic objectForKey:@"picUrl"]  forKey:@"imageUrl"];
                        [descDic setObject:dic[@"productId"] forKey:@"goodsId"];
                        
                        [descPicArray addObject:descDic];
                    }
                      [dict setObject:descPicArray forKey:@"imageDesc"];
                }
                
              
                
            }
            
            _goodsInfo = [goodsDetailInfo fetchWithDictionary:dict];
            
        }
        
        
        
        if (goodsDetailBlock) {
            goodsDetailBlock(YES,_goodsInfo);
        }
        else
        {
            goodsDetailBlock(NO,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:view animated:YES];
            });
        }
        
        if (goodsDetailBlock) {
            goodsDetailBlock(NO,nil);
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
