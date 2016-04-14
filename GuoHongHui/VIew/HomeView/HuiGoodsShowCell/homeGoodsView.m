//
//  homeGoodsView.m
//  GuoHongHui
//
//  Created by mac on 15/7/16.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "homeGoodsView.h"
#import <UIImageView+AFNetworking.h>

@implementation homeGoodsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [self addSubview:_imgView];
        
        _shadeView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.width - 25, frame.size.width, 25)];
        _shadeView.backgroundColor = [UIColor grayColor];
        _shadeView.alpha = 0.5;
//        [self addSubview:_shadeView];
        
//        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.width - 25, frame.size.width/2.0f, 25)];
        _goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame), frame.size.width, 30)];
        _goodsNameLabel.font = FONT14;
        _goodsNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_goodsNameLabel];
        
//        _huiPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2.0f, frame.size.width - 25, frame.size.width/2.0f - 10, 25)];
        _huiPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_goodsNameLabel.frame) , frame.size.width, 20)];
        _huiPriceLabel.textAlignment =  NSTextAlignmentCenter;
        _huiPriceLabel.font = FONT16;
        _huiPriceLabel.textColor = GLOBAL_RedColor;
        [self addSubview:_huiPriceLabel];
    }
    
    
    return self;
}

- (void)viewFillGoodsDetailInfo:(goodsDetailInfo *)info
{
    [_imgView setImageWithURL:[NSURL URLWithString:info.imgStr] placeholderImage:GHSMALLIMAGE];
    [_goodsNameLabel setText:info.goodsTitle];
    
    [_huiPriceLabel setText:[NSString stringWithFormat:@"¥ %@惠币",info.huiPrice]];
    
    
}

#pragma mark --
#pragma mark -- setter and getter


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
