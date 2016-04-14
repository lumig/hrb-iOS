//
//  ShopCarGoodsTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//购物车商品列表

#import <UIKit/UIKit.h>
#import "goodsDetailInfo.h"

@protocol ShopCarGoodsTableViewCellDelegate <NSObject>

- (void)btnClick:(UITableViewCell *)cell andFlag:(NSInteger )flag;

- (void)selectBtnClick:(UITableViewCell *)cell ;

- (void)goodsImgViewClick;

@end

@interface ShopCarGoodsTableViewCell : UITableViewCell

@property(nonatomic,assign)id<ShopCarGoodsTableViewCellDelegate> delegate;

@property(nonatomic,assign)BOOL isSelected;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *huiPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *minusBtn;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;


- (void)cellFillWithgoodsDetailInfo:(goodsDetailInfo *)info;

+ (CGFloat)cellHeight;


@end
