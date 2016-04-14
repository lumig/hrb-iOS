//
//  GoodsDetailTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"
#import "goodsDetailInfo.h"

@protocol GoodsDetailTableViewCellDelegate <NSObject>

- (void)goodsMessageViewClick;

- (void)buyRecordViewClick;

- (void)minusBtnAndAddBtnClick:(NSInteger)index;

@end

@interface GoodsDetailTableViewCell : UITableViewCell<EScrollerViewDelegate>

@property(nonatomic,strong)id<GoodsDetailTableViewCellDelegate> delegate;

@property(nonatomic,strong)EScrollerView *escrollerView;
@property(nonatomic,strong)UILabel *goodsTitleLabel;
@property(nonatomic,strong)UILabel *goodsDescLabel;

@property(nonatomic,strong)UIImageView *rightArrow1ImgView;
@property(nonatomic,strong)UIImageView *rightArrow2ImgView;
//商品信息
@property(nonatomic,strong)UIView *goodsMessageView;

@property(nonatomic,strong)UILabel *prePriceLabel;
//原价划线
@property(nonatomic,strong)UIImageView *prePriceLineImgView;

@property(nonatomic,strong)UILabel *huiPriceLabel;

//商品数量
@property(nonatomic,strong)UILabel *goodsNumLabel;
@property(nonatomic,strong)UIButton *minusBtn;
@property(nonatomic,strong)UIButton *addBtn;

//还剩多少件
@property(nonatomic,strong)UILabel *lastGoodsNumLabel;
//倒计时
@property(nonatomic,strong)UILabel *endTimeLabel;
//换购记录
@property(nonatomic,strong)UIView *buyRecordView;

@property(nonatomic,strong)UILabel *buyRecordLabel;

@property(nonatomic,assign)CGFloat goodsDescHeight;



- (void)fillWithGoodsDetailInfo:(goodsDetailInfo *)info;

+ (CGFloat)cellHeight;

@end
