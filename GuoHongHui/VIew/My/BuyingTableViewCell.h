//
//  BuyingTableViewCell.h
//  GuoHongHui
//
//  Created by LuMig on 15/6/23.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//订单进行中、

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
#import "OrderModel.h"
@protocol BuyingTableViewCellDelegate <NSObject>

- (void)buyingButtonClickWithIndex:(NSInteger)index;

- (void)cellImgViewClick;


@end

@interface BuyingTableViewCell : UITableViewCell

@property(nonatomic,assign) id<BuyingTableViewCellDelegate> delegate;

@property(nonatomic,strong)UILabel *orderIDLabel;
@property(nonatomic,strong)UILabel *goodsNumLabel;
@property(nonatomic,strong)UILabel *orderTotalLabel;
@property(nonatomic,strong)UIView *cellView;
@property(nonatomic,strong)UIImageView *smallPointImgView;
@property(nonatomic,strong)UIImageView *firstGoodsImgView;
@property(nonatomic,strong)UIImageView *secondGoodsImgView;
@property(nonatomic,strong)UIView *topLineView;
@property(nonatomic,strong)UIView *bottomLineView;
@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,assign)CGFloat goodsNumOffset;
@property(nonatomic,assign)CGFloat cellHeight;

//cell之间的间隔
@property(nonatomic,strong)UIImageView *bottomImgView;

- (void)fillWithOrderInfo:(OrderInfo *)info;

- (void)fillWithOrderModel:(OrderModel *)info indexRow:(NSInteger)index;
+ (CGFloat)heightForCell;

@end


