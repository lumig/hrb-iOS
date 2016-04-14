//
//  ProjectListInfo.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectListInfo.h"

@implementation ProjectListInfo

+ (ProjectListInfo *)fetchProjectListInfoWithDict:(NSDictionary *)dict
{
    ProjectListInfo *info = [[ProjectListInfo alloc] init];
    info.projectID = [dict objectForKey:@"projectId"];
    info.projectName = [dict objectForKey:@"projectTitle"];
    info.projectDesc = [dict objectForKey:@"projectDetail"];
    info.projectImgUrl = [dict objectForKey:@"projectUrl"];
//    info.createTime = [dict objectForKey:@"createtime"];
//    info.haveSelected = [dict objectForKey:@"yitou"];
    
    return info;
}

@end
