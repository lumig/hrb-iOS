//
//  ShopCarGoodsTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ShopCarGoodsTableViewCell.h"
#import <UIImageView+AFNetworking.h>
@implementation ShopCarGoodsTableViewCell

- (void)awakeFromNib {
    
    self.minusBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.minusBtn.layer.cornerRadius = 0.5;
    self.minusBtn.layer.masksToBounds = YES;
    
    self.goodsNumLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.goodsNumLabel.layer.cornerRadius = 0.5;
    self.goodsNumLabel.layer.masksToBounds = YES;
    
    self.addBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.addBtn.layer.cornerRadius = 0.5;
    self.addBtn.layer.masksToBounds = YES;
    
    [self.selectBtn addTarget:self action:@selector(selectbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.minusBtn.tag = 11;
    
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.tag = 12;
    
    self.goodsImgView.userInteractionEnabled = YES;
    self.goodsNameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewClick)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewClick)];
    [self.goodsImgView addGestureRecognizer:tap];
    
    [self.goodsNameLabel addGestureRecognizer:tap1];
}


- (void)cellFillWithgoodsDetailInfo:(goodsDetailInfo *)info
{
    if (info.isSelected) {
        
        [self.selectBtn setImage:[UIImage imageNamed:@"i_checkbx_on.png"] forState:UIControlStateNormal];
        self.isSelected = YES;
    }
    else
    {
        [self.selectBtn setImage:[UIImage imageNamed:@"i_checkbx_off.png"] forState:UIControlStateNormal];
        self.isSelected = NO;
        
    }
    
    
    
    [self.goodsImgView setImageWithURL:[NSURL URLWithString:info.imgStr] placeholderImage:GHSMALLIMAGE];
    
    [self.goodsNameLabel setText:info.goodsTitle];
    
    [self.huiPriceLabel setText:[NSString stringWithFormat:@"%@",info.huiPrice]];
    
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"%@",info.goodsNum]];
    

    
}

- (void)selectbtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(selectBtnClick:)]) {
        [self.delegate selectBtnClick:self];

    }
}

- (void)minusBtnClick:(UIButton *)btn
{
    if (self.isSelected == YES ) {
        
        if ([self.delegate respondsToSelector:@selector(btnClick:andFlag:)]) {
            [self.delegate btnClick:self andFlag:btn.tag];

        }
    }
}

- (void)addBtnClick:(UIButton *)btn
{
    if (self.isSelected == YES) {
        
        if ([self.delegate respondsToSelector:@selector(btnClick:andFlag:)]) {
            [self.delegate btnClick:self andFlag:btn.tag	];

        }
    }
}

- (void)imgViewClick
{
    if ([self.delegate respondsToSelector:@selector(goodsImgViewClick)]) {
        
        [self.delegate goodsImgViewClick];
    }
}

+ (CGFloat)cellHeight
{
    return 75;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
