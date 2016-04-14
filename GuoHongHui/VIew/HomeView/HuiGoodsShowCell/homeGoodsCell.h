//
//  homeGoodsCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/16.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeGoodsView.h"

#import "goodsDetailInfo.h"
@interface homeGoodsCell : UITableViewCell

@property(nonatomic,strong)homeGoodsView *leftImgView;
@property(nonatomic,strong)homeGoodsView *rightImgView;

@property(nonatomic,assign)NSUInteger leftRow;
@property(nonatomic,assign)NSUInteger rightRow;

- (void)cellFillLeftModel:(goodsDetailInfo *)leftModel leftRow:(NSUInteger)leftRow rightModel:(goodsDetailInfo *)rightModel rightRow:(NSUInteger)rightRow;

+ (CGFloat)cellHeight;


@end
