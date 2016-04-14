//
//  ProjectProgressModel.h
//  GuoHongHui
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ProjectProgressBlock)(BOOL state,NSMutableArray *dataArray);
typedef void (^FailureBlock)(BOOL state);
@interface ProjectProgressModel : NSObject
@property(nonatomic,strong)NSMutableArray *dataArray;

- (void)getProjectProgressDataWithView:(UIView *)view andProjectId:(NSNumber *)projectID ProjectProgressBlock:(ProjectProgressBlock)projectProgressBlock failureBlock:(FailureBlock)failureBlock;

@end
