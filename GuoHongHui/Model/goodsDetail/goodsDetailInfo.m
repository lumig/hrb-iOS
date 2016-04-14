//
//  goodsDetailInfo.m
//  GuoHongHui
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "goodsDetailInfo.h"

@implementation goodsDetailInfo

//-(instancetype)initWithDictionary:(NSDictionary *)dic;
//{
//    self=[super init];
//    if (self)
//    {
//        if (dic == nil) {
//            return nil;
//        }
//        
//        self.goodsID = [dic objectForKey:@"productId"];
//        self.imgArray=[dic objectForKey:@"imgArray"];
//        self.imgStr = [dic objectForKey:@"productUrl"];
//        self.goodsTitle=[dic objectForKey:@"productName"];
//        self.goodsNum=[dic objectForKey:@"goodsNum"];
//        self.goodDesc = [dic objectForKey:@"goodDesc"];
////        self.prePrice = [dic objectForKey:@"prePrice"];
//        self.huiPrice = [dic objectForKey:@"productPrice"];
////        self.lastGoodsNum = [dic objectForKey:@"lastGoodsNum"];
//        self.buyRecord = [dic objectForKey:@"buyRecord"];
//        self.isSelected = [dic objectForKey:@"isSelected"];
//    }
//    
//    return self;
//
//}

+(goodsDetailInfo *)fetchWithDictionary:(NSDictionary *)dic
{
    goodsDetailInfo *info = [[goodsDetailInfo alloc] init];
    
    if ([dic isKindOfClass:[NSDictionary class]]) {
        info.goodsID = [dic objectForKey:@"productId"];
        info.imgArray=[dic objectForKey:@"imgArray"];
        info.imgStr = [dic objectForKey:@"productUrl"];
        info.goodsTitle=[dic objectForKey:@"productName"];
        info.goodsNum=[dic objectForKey:@"goodsNum"];
        info.goodDesc = [dic objectForKey:@"productDetail"];
        //        self.prePrice = [dic objectForKey:@"prePrice"];
        info.huiPrice = [dic objectForKey:@"productPrice"];
        //        self.lastGoodsNum = [dic objectForKey:@"lastGoodsNum"];
        info.buyRecord = [dic objectForKey:@"buyRecord"];
        info.isSelected = [dic objectForKey:@"isSelected"];
        info.descPicArray = [dic objectForKey:@"imageDesc"];
        info.buyRecord = [dic objectForKey:@"productCount"];
        
//        NSLog(@"goodsName%@",info.goodsTitle);
    }
    return info;
}


@end
