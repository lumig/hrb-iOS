//
//  SignInModel.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "SignInModel.h"

@implementation SignInModel

+ (SignInModel *)fetchWithDict:(NSDictionary *)dict
{
    SignInModel *model = [[SignInModel alloc] init];
    model.codeAdd = [dict objectForKey:@"num"];
    model.sourece = [dict objectForKey:@"reason"];
    model.create = [SignInModel changeWithArray:[dict objectForKey:@"signinTime"]];
    model.type = @"0";
    return model;
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
