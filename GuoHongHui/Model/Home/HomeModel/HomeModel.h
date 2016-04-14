//
//  HomeModel.h
//  GuoHongHui
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LastestNewsModel.h"
#import "goodsDetailInfo.h"

typedef void (^SuccessBlock)(BOOL state,NSMutableDictionary *dataDict);
typedef void (^FailureBlock)(BOOL state);

@interface HomeModel : NSObject
@property(nonatomic,strong)NSMutableDictionary *dataDict;


- (void)getDataWithView:(UIView *)view successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
