//
//  ProjectProgressInfo.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectProgressInfo.h"

@implementation ProjectProgressInfo

+(ProjectProgressInfo *)fetchWithProjectProgressDict:(NSDictionary *)dict
{
    ProjectProgressInfo *info = [[ProjectProgressInfo alloc] init];
    
    info.projectID = [dict objectForKey:@"projectId"];
    info.projectName = [dict objectForKey:@"projectTitle"];
    info.projectDesc = [dict objectForKey:@"phaseDetail"];
    info.projectImgUrl = [dict objectForKey:@"projectUrl"];
    info.publicTime = [ProjectProgressInfo changeWithArray:[dict objectForKey:@"phaseDate"]];
    info.imgArray = [dict objectForKey:@"imgArray"];
    
    return info;
}

+ (NSString *)changeWithArray:(NSArray *)array
{
    NSString *str = @"";
    NSString *inter;
    for (int i = 0; i < array.count; ++i) {
        inter = array[i];
        str= [str stringByAppendingString:[NSString stringWithFormat:@"%@-",inter]];
    }
    NSRange range = NSMakeRange(0, str.length - 1);
    
    str = [str substringWithRange:range];
    return str;
}

@end
