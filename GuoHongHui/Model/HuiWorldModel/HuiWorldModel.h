//
//  HuiWorldModel.h
//  GuoHongHui
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HuiWorldBlock)(BOOL state, NSMutableDictionary *dataDict);
typedef void (^FailureBlock)(BOOL state);

@interface HuiWorldModel : NSObject

@property(nonatomic,strong)NSMutableDictionary *dataDict;

- (void)getHuiWorldDataWithView:(UIView *)view  HuiWorldBlock:(HuiWorldBlock)huiWorldBlock failureBlock:(FailureBlock)failureBlock;

@end
