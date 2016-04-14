//
//  ProjectCenterModel.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectListInfo.h"

typedef void (^ProjectCenterBlock)(BOOL state,NSMutableArray *dataArray);
typedef void (^FailureBlock)(BOOL state);
typedef void(^isReadingBlcok) (BOOL isReading);
@interface ProjectCenterModel : NSObject

@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)NSInteger *offset;


//获取项目中心数据

- (void)getProjectDataWithView:(UIView *)view andProjectCenterBlock:(ProjectCenterBlock)projectCenterBlock andFailureBlock:(FailureBlock)failureBlock;


- (void)getProjectCenterDataWithPage:(NSNumber *)page andProjectCenterBlock:(ProjectCenterBlock)projectCenterBlock;

- (void)getMoreDataProjectCenterWithMemberID:(NSString *)memberID andPage:(NSNumber *)page andProjectCenterBlock:(ProjectCenterBlock)projectCenterBlock;


@end
