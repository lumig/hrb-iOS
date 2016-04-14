//
//  OrderGoodsMessTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsDetailInfo.h"

@interface OrderGoodsMessTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;


@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;



- (void)cellFillWithGoodsDetailInfo:(goodsDetailInfo *)info;

- (void)cellFillWithGoodsWithDict:(NSDictionary *)dict;

+(CGFloat)cellHeight;
@end
