//
//  goodsDetailInfo.h
//  GuoHongHui
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsDetailInfo : NSObject


@property(nonatomic,strong)NSNumber *goodsID;

@property(nonatomic,strong)NSArray *imgArray;
//保存商品图片数组中的一张
@property(nonatomic,strong)NSString *imgStr;
@property(nonatomic,strong)NSString *goodsTitle;
@property(nonatomic,strong)NSString *goodDesc;
@property(nonatomic,strong)NSNumber *prePrice;
@property(nonatomic,strong)NSNumber *huiPrice;
//剩余商品件数
@property(nonatomic,strong)NSNumber *lastGoodsNum;
//结束时间
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSNumber *buyRecord;
//购买商品件数
@property(nonatomic,strong)NSNumber *goodsNum;
//是否选中
@property(nonatomic,assign)BOOL isSelected;
//图文描述
@property(nonatomic,strong)NSArray *descPicArray;

////产品图片和描述组
//@property(nonatomic,strong)NSArray *goodsListArray;


+(goodsDetailInfo *)fetchWithDictionary:(NSDictionary *)dic;

@end
