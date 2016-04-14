//
//  HuiGoodsShowTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiGoodsShowTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#define ImgViewHeight  (SCREEN_WIDTH==320.0 ? 120:150)

#define kGap (SCREEN_WIDTH==320.0 ? 10:15)
@implementation HuiGoodsShowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.goodsImgView];
        [self addSubview:self.shadeView];
        [self addSubview:self.goodsDescLabel];
        [self addSubview:self.goodsTitleLabel];
        [self addSubview:self.huiPriceLabel];
        [self addSubview:self.bottomLineView];
    }
    
    return self;
    
}

#pragma mark --
#pragma mark -- event reponse
- (void)fillWithGoodsDetailInfo:(goodsDetailInfo *)info
{
    if (info.imgArray.count > 0) {
        
        [self.goodsImgView setImageWithURL:[NSURL URLWithString:info.imgArray[0]] placeholderImage:GHSMALLIMAGE];
    }
    
    self.goodsDescLabel.text = [NSString stringWithFormat:@"%@",info.goodDesc];
    
    self.goodsTitleLabel.text = [NSString stringWithFormat:@"%@",info.goodsTitle];
    
    self.huiPriceLabel.text = [NSString stringWithFormat:@"惠价格：%@",info.huiPrice];
}

+(CGFloat)heightForCell
{
    return ImgViewHeight + 40 + 30;
}


#pragma mark --
#pragma mark -- setter and getter



- (UIImageView *)goodsImgView
{
    if (_goodsImgView == nil) {
        
        _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake( kGap, 0, SCREEN_WIDTH - 2 *kGap , ImgViewHeight)];
    }
    
    return _goodsImgView;
}

- (UIView *)shadeView
{
    if (_shadeView == nil) {
        
        _shadeView = [[UIView alloc] initWithFrame:CGRectMake(kGap, ImgViewHeight - 20.0, SCREEN_WIDTH - 2 * kGap, 20)];
        _shadeView.backgroundColor = [UIColor grayColor];
        _shadeView.alpha = 0.5;
    }
    return _shadeView;
}

- (UILabel *)goodsDescLabel
{
    if (_goodsDescLabel == nil) {
        
        _goodsDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 +kGap, ImgViewHeight - 20.0, SCREEN_WIDTH - 3 *kGap, 20)];
        [_goodsDescLabel setFont:FONT15];
        _goodsDescLabel.textColor = [UIColor whiteColor];
    }
    
    return _goodsDescLabel;
}

- (UILabel *)goodsTitleLabel
{
    if (_goodsTitleLabel == nil) {
        
        _goodsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 +kGap, ImgViewHeight + 5, SCREEN_WIDTH - 3 *kGap, 20)];
        _goodsTitleLabel.font = FONT15;
        _goodsTitleLabel.textColor = [UIColor blackColor];
    }
    return _goodsTitleLabel;
}

- (UILabel *)huiPriceLabel
{
    if (_huiPriceLabel == nil) {
        
        _huiPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 +kGap, ImgViewHeight + 30, SCREEN_WIDTH - 3 *kGap, 20)];
        _huiPriceLabel.font = FONT16;
        ;
        _huiPriceLabel.textColor =GLOBAL_RedColor;
    }
    
    return _huiPriceLabel;
}

- (UIImageView *)bottomLineView
{
    if (_bottomLineView == nil) {
        
        _bottomLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ImgViewHeight + 40 + 15, SCREEN_WIDTH, 15)];
        [_bottomLineView setBackgroundColor:GLOBAL_GrayColor];
    }
    return _bottomLineView;
}

@end
