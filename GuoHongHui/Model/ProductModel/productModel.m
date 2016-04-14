      //
//  productModel.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "productModel.h"

@implementation productModel

+ (productModel *)fetchWithDict:(NSDictionary *)dict
{
    productModel *model = [[productModel alloc] init];
    NSDictionary *exDict = [dict[@"invertRecord"] mutableCopy];
    model.interest = [dict objectForKey:@"interest"];
    model.totalInvestment = [dict objectForKey:@"sum"];
    model.productName = [exDict objectForKey:@"categoryName"];
    model.purchaseDate = [productModel changeWithArray:[exDict objectForKey:@"investmentDate"]];
    model.earningDate = [productModel changeWithArray:[exDict objectForKey:@"endDate"]];
    model.rate = [exDict objectForKey:@"rate"];
    model.principal = [exDict objectForKey:@"investmentVolume"];
    return model;
}
+ (productModel *)fetchWithOnlyDict:(NSDictionary *)dict
{
    productModel *model = [[productModel alloc] init];
    model.productName = [dict objectForKey:@"categoryName"];
    model.purchaseDate = [productModel changeWithArray:[dict objectForKey:@"investmentDate"]];
    model.earningDate = [productModel changeWithArray:[dict objectForKey:@"endDate"]];
    model.rate = [dict objectForKey:@"rate"];
    model.principal = [dict objectForKey:@"investmentVolume"];
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
