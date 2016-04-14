//
//  ProjectProgressInfo.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectProgressInfo : NSObject

@property(nonatomic,strong)NSNumber *projectID;
@property(nonatomic,strong)NSString *projectName;
@property(nonatomic,strong)NSString *projectDesc;
@property(nonatomic,strong)NSString *publicTime;
@property(nonatomic,strong)NSString *projectImgUrl;
@property(nonatomic,strong)NSArray *imgArray;

+(ProjectProgressInfo *)fetchWithProjectProgressDict:(NSDictionary *)dict;
+ (NSString *)changeWithArray:(NSArray *)array;
@end
