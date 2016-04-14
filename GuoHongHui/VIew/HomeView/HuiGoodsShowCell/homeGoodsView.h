//
//  homeGoodsView.h
//  GuoHongHui
//
//  Created by mac on 15/7/16.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsDetailInfo.h"
@interface homeGoodsView : UIView

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIView *shadeView;
@property(nonatomic,strong)UILabel *goodsNameLabel;
@property(nonatomic,strong)UILabel *huiPriceLabel;


- (void)viewFillGoodsDetailInfo:(goodsDetailInfo *)info;

@end
