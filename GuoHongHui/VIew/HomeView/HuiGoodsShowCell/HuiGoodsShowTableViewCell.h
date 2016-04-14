//
//  HuiGoodsShowTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsDetailInfo.h"
@interface HuiGoodsShowTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *goodsImgView;
//阴影遮罩层
@property(nonatomic,strong)UIView *shadeView;
@property(nonatomic,strong)UILabel *goodsDescLabel;
@property(nonatomic,strong)UILabel *goodsTitleLabel;
@property(nonatomic,strong)UILabel *huiPriceLabel;

@property(nonatomic,strong)UIImageView *bottomLineView;

- (void)fillWithGoodsDetailInfo:(goodsDetailInfo *)info;
+ (CGFloat)heightForCell;
@end
