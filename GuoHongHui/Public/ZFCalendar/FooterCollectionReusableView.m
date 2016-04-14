//
//  FooterCollectionReusableView.m
//  Calendar
//
//  Created by LuMig on 15/5/20.
//  Copyright (c) 2015年 张凡. All rights reserved.
//

#import "FooterCollectionReusableView.h"

@implementation FooterCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.waitingImgView];
        
        [self addSubview:self.waitingNameLabel];
        
        [self addSubview:self.waitingMoneyLabel];
        
//        [self addSubview:self.havingMoneyLabel];
//        
//        [self addSubview:self.havingImgView];
//        
//        [self addSubview:self.havingNameLabel];
        
        
    }
    return self;
}

- (UIImageView *)waitingImgView
{
    if (_waitingImgView ==  nil) {
        _waitingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
        [_waitingImgView setImage:[UIImage imageNamed:@"daishouall.png"]];
    }
    return _waitingImgView;
}

- (UILabel *)waitingNameLabel
{
    if (_waitingNameLabel == nil) {
        
        _waitingNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 12, 100, 19)];
        [_waitingNameLabel setFont:FONT15];
        [_waitingNameLabel setTextAlignment:NSTextAlignmentLeft];
        
    }   
    return _waitingNameLabel;
}

- (UILabel *)waitingMoneyLabel
{
    if (_waitingMoneyLabel == nil) {
        
        _waitingMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 120, 14, 100, 16)];
        
        [_waitingMoneyLabel setFont:FONT15];
        [_waitingMoneyLabel setTextAlignment:NSTextAlignmentRight];
        
    }
    
    return _waitingMoneyLabel;
}

- (UIImageView *)havingImgView
{
    if (_havingImgView == nil) {
        
        _havingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 35, 20, 20)];
        [_havingImgView setImage:[UIImage imageNamed:@"chiyouzhong.png"]];
        
    }
    return _havingImgView;
}

- (UILabel *)havingNameLabel
{
    if (_havingNameLabel == nil) {
        
        _havingNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 37, 100, 21)];
        [_havingNameLabel setFont:FONT15];
        [_havingNameLabel setTextAlignment:NSTextAlignmentLeft];
        
    }
    
    return _havingNameLabel;
}

- (UILabel *)havingMoneyLabel
{
    if (_havingMoneyLabel == nil) {
        
        _havingMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 120, 37, 100, 21)];
        [_havingMoneyLabel setFont:FONT15];
        [_havingMoneyLabel setTextAlignment:NSTextAlignmentRight];
        
    }
    return _havingMoneyLabel;
}

@end
