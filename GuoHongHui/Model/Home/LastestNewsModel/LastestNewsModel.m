//
//  LastestNewsModel.m
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "LastestNewsModel.h"

@implementation LastestNewsModel

+ (LastestNewsModel *)fetchWithLastestNewsDict:(NSDictionary *)dict
{
    LastestNewsModel *info = [[LastestNewsModel alloc] init];
    info.newsName = [dict objectForKey:@"newsName"];
    info.newsId = [dict objectForKey:@"newsId"];
    info.newsDesc = [dict objectForKey:@"newsDescription"];
    info.imgView = [dict objectForKey:@"imageUrl"];
    info.newsUrl = [dict objectForKey:@"newsUrl"];
    
    
    return info;
}

@end
