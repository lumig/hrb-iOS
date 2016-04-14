//
//  OrderGoodsMessTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "OrderGoodsMessTableViewCell.h"
#import <UIImageView+AFNetworking.h>


@implementation OrderGoodsMessTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellFillWithGoodsDetailInfo:(goodsDetailInfo *)info
{
    [self.goodsImgView setImageWithURL:[NSURL URLWithString:info.imgStr] placeholderImage:GHSMALLIMAGE];
    self.goodsNameLabel.text= info.goodsTitle;
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"数量：%@",info.goodsNum]];
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"%@",info.huiPrice]];
    [self.numLabel setText:[NSString stringWithFormat:@"x %@",info.goodsNum]];
}

- (void)cellFillWithGoodsWithDict:(NSDictionary *)dict
{
    [self.goodsImgView setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"imgStr"]] placeholderImage:GHSMALLIMAGE];
    self.goodsNameLabel.text= [NSString stringWithFormat:@"%@",[dict objectForKey:@"goodsTitle"]];
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"数量：%@",dict[@"goodsNum"]]];
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"%@",dict[@"huiPrice"]]];
    [self.numLabel setText:[NSString stringWithFormat:@"x %@",dict[@"goodsNum"]]];
}

+(CGFloat)cellHeight
{
    return 70;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
