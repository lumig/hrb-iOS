//
//  ProjectListModel.h
//  GuoHongHui
//
//  Created by mac on 15/8/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectListInfo.h"

typedef void (^ProjectListBlock)(BOOL state,NSMutableArray *dataArray);
typedef void (^FailureBlock)(BOOL state);

@interface ProjectListModel : NSObject


@property(nonatomic,strong)NSMutableArray *dataArray;


- (void)getProjectListDataWithView:(UIView *)view ProjectListBlock:(ProjectListBlock)projectListBlock failureBlock:(FailureBlock)failureBlock;



@end
