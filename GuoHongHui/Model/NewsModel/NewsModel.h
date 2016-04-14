//
//  NewsModel.h
//  GuoHongHui
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LastestNewsModel.h"

typedef void (^NewsBlock)(BOOL state,NSMutableArray *dataArray);
typedef void (^FailureBlock)(BOOL state);

@interface NewsModel : NSObject

@property(nonatomic,strong)NSMutableArray *dataArray;

- (void)getNewsDataWithView:(UIView *)view NewsBlock:(NewsBlock)newsBlock failureBlock:(FailureBlock)failureBlock;

@end
