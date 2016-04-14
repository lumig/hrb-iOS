//
//  ActivityModel.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property(nonatomic,strong)NSString *showLabelName;
@property(nonatomic,strong)NSArray *atLabelArray;
@property(nonatomic,strong)NSString *leftImgUrl;
@property(nonatomic,strong)NSString *rightImgUrl;

+ (ActivityModel *)fetchActivityModel:(NSDictionary *)dic;

+(ActivityModel *)shareActivityModel;


- (ActivityModel *)fetchActivityModel:(NSDictionary *)dic;
@end
