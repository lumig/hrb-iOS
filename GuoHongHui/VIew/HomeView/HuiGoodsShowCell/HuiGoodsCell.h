//
//  HuiGoodsCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsDetailInfo.h"
#import "homeGoodsView.h"


@interface HuiGoodsCell : UITableViewCell

@property(nonatomic,strong)homeGoodsView *leftImgView;
@property(nonatomic,strong)homeGoodsView *middleImgView;
@property(nonatomic,strong)homeGoodsView *rightImgView;

@property(nonatomic,assign)NSUInteger leftRow;
@property(nonatomic,assign)NSUInteger middleRow;
@property(nonatomic,assign)NSUInteger rightRow;

- (void)cellFillLeftModel:(goodsDetailInfo *)leftModel leftRow:(NSUInteger)leftRow andMiddleModel:(goodsDetailInfo *)middleModel middletRow:(NSUInteger)middleRow andRightModel:(goodsDetailInfo *)rightModel rightRow:(NSUInteger)rightRow;

+ (CGFloat)cellHeight;
@end
