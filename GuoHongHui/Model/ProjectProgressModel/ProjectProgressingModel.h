//
//  ProjectProgressingModel.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectProgressInfo.h"


typedef void (^ProjectProgressingBlock)(BOOL state, NSMutableArray *dataArr);
@interface ProjectProgressingModel : NSObject

@property(nonatomic,strong)NSMutableArray *dataArray;

//项目进展
- (void)getProjectProgressingDataWithProjectID:(NSString *)projectID andPage:(NSNumber *)page andProjectProgressingBlock:(ProjectProgressingBlock)projectProgressingBlock;

@end
