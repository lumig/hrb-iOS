//
//  GoodsDetailModel.h
//  GuoHongHui
//
//  Created by mac on 15/8/4.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "goodsDetailInfo.h"
typedef void(^GoodsDetailBlock) (BOOL state,goodsDetailInfo *goodsInfo);
typedef void (^FailureBlock)(BOOL state);

@interface GoodsDetailModel : NSObject

@property(nonatomic,strong)goodsDetailInfo *goodsInfo;

- (void)getGoodsDetailDataWithView:(UIView *)view andproductId:(NSNumber *)productID GoodsDetailBlock:(GoodsDetailBlock)goodsDetailBlock failureBlock:(FailureBlock)failureBlock;

@end
