//
//  ProjectListInfo.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectListInfo : NSObject
@property(nonatomic,strong)NSNumber *projectID;
@property(nonatomic,strong)NSString *projectName;
@property(nonatomic,strong)NSString *projectDesc;
@property(nonatomic,strong)NSString *projectImgUrl;
@property(nonatomic,strong)NSString *createTime;
//@property(nonatomic,strong)NSString *haveSelected;

+ (ProjectListInfo *)fetchProjectListInfoWithDict:(NSDictionary *)dict;
@end
