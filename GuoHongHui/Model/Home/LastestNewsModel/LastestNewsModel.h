//
//  LastestNewsModel.h
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastestNewsModel : NSObject

@property(nonatomic,strong)NSString *imgView;

@property(nonatomic,strong)NSString *newsName;

@property(nonatomic,strong)NSString *newsDesc;

@property(nonatomic,strong)NSString *newsUrl;
@property(nonatomic,strong)NSString *newsId;

+ (LastestNewsModel *)fetchWithLastestNewsDict:(NSDictionary *)dict;



@end
