//
//  HuiRongBaoModel.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/18.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HuiRongBaoInfo.h"


typedef void (^HuirongbaoBlock)(BOOL state, NSMutableArray *dataArray) ;
typedef void (^FailureBlock)(BOOL state);
@interface HuiRongBaoModel : NSObject


@property(nonatomic,strong)NSMutableArray *dataArray;

- (void)getHuirongbaoDataWithView:(UIView *)view HuirongbaoBlock:(HuirongbaoBlock)huirongbaoBlock failureBlock:(FailureBlock)failureBlock;

@end
