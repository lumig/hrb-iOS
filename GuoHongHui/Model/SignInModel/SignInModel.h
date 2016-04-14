//
//  SignInModel.h
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignInModel : NSObject
@property(nonatomic,strong)NSNumber *codeAdd;
//@property(nonatomic,strong)NSString *codeReduce;
@property(nonatomic,strong)NSString *sourece;
@property(nonatomic,strong)NSString *create;

@property(nonatomic,strong)NSString *type;

+ (SignInModel *)fetchWithDict:(NSDictionary *)dict;

@end
