//
//  HuiListModel.h
//  GuoHongHui
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HuiRongBaoInfo.h"

typedef void (^HuiListBlock)(BOOL state,NSMutableDictionary *dataDict);
typedef void (^FailureBlock)(BOOL state);
@interface HuiListModel : NSObject

@property(nonatomic,strong)NSMutableDictionary *dataDict;

- (void)getDataWithView:(UIView *)view categoryId:(NSString *)huiId successBlock:(HuiListBlock)successBlock failureBlock:(FailureBlock)failureBlock;
@end
