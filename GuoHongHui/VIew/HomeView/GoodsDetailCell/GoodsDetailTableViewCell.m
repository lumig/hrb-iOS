//
//  GoodsDetailTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//商品介绍
#import "GoodsDetailTableViewCell.h"
#import "GHStringManger.h"
#import "goodsDetailInfo.h"

#define EScrollerViewHeight  (SCREEN_WIDTH==320.0 ? 150:180)
#define descCellHeight (SCREEN_WIDTH==320.0 ? 300:340)

@implementation GoodsDetailTableViewCell

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
        
//        [self addSubview:self.escrollerView];
        
        [self addSubview:self.goodsMessageView];
        [self addSubview:self.goodsTitleLabel];
//        [self addSubview:self.prePriceLabel];
//        [self addSubview:self.prePriceLineImgView];
        [self addSubview:self.goodsNumLabel];
        [self addSubview:self.addBtn];
        [self addSubview:self.minusBtn];
        [self addSubview:self.huiPriceLabel];
//        [self addSubview:self.lastGoodsNumLabel];
//        [self addSubview:self.endTimeLabel];
        [self addSubview:self.buyRecordView];
        
    }
    
    return self;
}

#pragma mark --
#pragma mark -- event reponse
- (void)fillWithGoodsDetailInfo:(goodsDetailInfo *)info
{
    if (info.imgArray != nil) {
        if (info.imgArray.count > 0) {
            self.escrollerView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, EScrollerViewHeight) ImageArray:info.imgArray TitleArray:nil autoPlay:nil];

        }
        
        [self addSubview:self
         .escrollerView];
    }
    
    _goodsDescHeight = [GHStringManger stringBoundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 45, 2000) font:FONT15 text:info.goodDesc].height;
//    NSLog(@"gooddescHeight%f",_goodsDescHeight);
    
    self.goodsMessageView.frame = CGRectMake(0, CGRectGetMaxY(self.escrollerView.frame) , SCREEN_WIDTH , 15+ 20+ _goodsDescHeight);
    
    self.goodsTitleLabel.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 20);
    self.goodsTitleLabel.text = info.goodsTitle;
    
    [self.goodsMessageView addSubview:self.goodsTitleLabel];
    
    self.goodsDescLabel.frame = CGRectMake(15, CGRectGetMaxY(self.goodsTitleLabel.frame), SCREEN_WIDTH- 30, _goodsDescHeight);
    
    self.goodsDescLabel.text = info.goodDesc;
    
    [self.goodsMessageView addSubview:self.goodsDescLabel];
    
//    self.rightArrow1ImgView.frame = CGRectMake(SCREEN_WIDTH - 30, (15 + 20 + _goodsDescHeight - 15) , 10, 15);
//    [self.rightArrow1ImgView setImage:[UIImage imageNamed:@"i_arrow_gray_right.png"]];
//    [self.goodsMessageView addSubview:self.rightArrow1ImgView];
    
    //点击产品描述
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodsMessageClick)];
    [self.goodsMessageView addGestureRecognizer:tap];
    
//    self.prePriceLabel.frame = CGRectMake(15, CGRectGetMaxY(self.goodsMessageView.frame) + 10, [GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 20) font:FONT13 text:[NSString stringWithFormat:@"原价： ¥%@",info.prePrice]].width, 20);
//    [self.prePriceLabel setText:[NSString stringWithFormat:@"原价： ¥%@",info.prePrice]];
//    
//    
//    self.prePriceLineImgView.frame = CGRectMake([GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 20) font:FONT13 text:[NSString stringWithFormat:@"原价："]].width + 15, CGRectGetMaxY(self.prePriceLabel.frame)- 10 , [GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 20) font:FONT13 text:[NSString stringWithFormat:@" ¥%@ ",info.prePrice]].width, 1);
//
    UILabel *goodsNumLable = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.goodsMessageView.frame) + 10, [GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 20) font:FONT15 text:@"数量："].width, 20)];
    goodsNumLable.text = @"数量：";
    goodsNumLable.font = FONT15;
    
    [self addSubview:goodsNumLable];
    
    self.minusBtn.frame =CGRectMake(CGRectGetMaxX(goodsNumLable.frame) + 10, CGRectGetMaxY(self.goodsMessageView.frame) + 10, 20, 20);
    [self.minusBtn setImage:[UIImage imageNamed:@"i_minus.png"] forState:UIControlStateNormal];
    self.minusBtn.tag = 10;
    [self.minusBtn addTarget:self action:@selector(minusBtnAndAddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.goodsNumLabel.frame = CGRectMake(CGRectGetMaxX(self.minusBtn.frame), CGRectGetMaxY(self.goodsMessageView.frame) + 10, 40, 20);
    self.goodsNumLabel.textAlignment = NSTextAlignmentCenter;
    self.goodsNumLabel.font = FONT16;
    self.goodsNumLabel.text = [NSString stringWithFormat:@"%@",info.goodsNum];
    
    
    self.addBtn.frame = CGRectMake(CGRectGetMaxX(self.goodsNumLabel.frame),  CGRectGetMaxY(self.goodsMessageView.frame) + 10, 20, 20);
    self.addBtn.tag =11;
    [self.addBtn setImage:[UIImage imageNamed:@"i_plus.png"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(minusBtnAndAddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.huiPriceLabel.frame = CGRectMake(15, CGRectGetMaxY(self.minusBtn.frame) +10, 200, 20);
    
    [self.huiPriceLabel setText:[NSString stringWithFormat:@"惠特价： %@惠金币",info.huiPrice]];
    
    self.lastGoodsNumLabel.frame = CGRectMake(SCREEN_WIDTH - 150, CGRectGetMaxY(self.minusBtn.frame) +10, 135, 20);
    [self.lastGoodsNumLabel setText:[NSString stringWithFormat:@"还剩%@件",info.lastGoodsNum]];
    
    [self.endTimeLabel setFrame:CGRectMake(15, CGRectGetMaxY(self.huiPriceLabel.frame) + 15, 200, 20)];
    [self.endTimeLabel setText:[NSString stringWithFormat:@"距结束：%@",info.endTime]];
   
    
    [self.buyRecordView setFrame:CGRectMake(0, CGRectGetMaxY(self.huiPriceLabel.frame) , SCREEN_WIDTH, 44)];
    NSLog(@"rectshow%@",NSStringFromCGRect(self.buyRecordView.frame));
    
    //点击换购记录
    UITapGestureRecognizer *buyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buyRecordClick)];
    [self.buyRecordView addGestureRecognizer:buyTap];
    
    [self.buyRecordLabel setFrame:CGRectMake(15, 12, 200, 20)];
    [self.buyRecordLabel setText:[NSString stringWithFormat:@"换购记录（%@）",info.buyRecord]];
    [self.buyRecordView addSubview:self.buyRecordLabel];
    
    [self.rightArrow2ImgView setFrame:CGRectMake(SCREEN_WIDTH - 25, (44-15)/2.0, 10, 15)];
    [self.rightArrow2ImgView setImage:[UIImage imageNamed:@"i_arrow_gray_right.png"]];
    [self.buyRecordView addSubview:self.rightArrow2ImgView];
    
    
}

+(CGFloat)cellHeight
{
    return descCellHeight;
}

#pragma mark -- goodsmessClick
- (void)goodsMessageClick
{
    if ([self.delegate respondsToSelector:@selector(goodsMessageViewClick)]) {
        
        [self.delegate goodsMessageViewClick];
    }
}

#pragma mark -- buyRecordClick
- (void)buyRecordClick
{
    if ([self.delegate respondsToSelector:@selector(buyRecordViewClick)]) {
        [self.delegate buyRecordViewClick];
    }
}

#pragma mark -- cell点击失效
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
   
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


- (void)minusBtnAndAddBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag;
    
    if ([self.delegate respondsToSelector:@selector(minusBtnAndAddBtnClick:)]) {
        [self.delegate minusBtnAndAddBtnClick:index];
    }
//    switch (index) {
//        case 10:
//        {
//            if ([self.goodsNumLabel.text isEqual:@"1"]) {
//                
//            }else
//            {
//                int num = [self.goodsNumLabel.text intValue];
//                num --;
//                
//                self.goodsNumLabel.text = [NSString stringWithFormat:@"%d",num];
//            }
//            break;
//        }
//        
//        case 11:
//        {
//            int num = [self.goodsNumLabel.text intValue];
//            num ++;
//            
//            self.goodsNumLabel.text = [NSString stringWithFormat:@"%d",num];
//            break;
//        }
//        default:
//            break;
//    }
}

#pragma mark --
#pragma mark -- setter and getter

//- (EScrollerView *)escrollerView
//{
//    if (_escrollerView == nil) {
//        _escrollerView = [[EScrollerView alloc] init];
//        _escrollerView.delegate = self;
//    }
//    return _escrollerView;
//}

- (UILabel *)goodsTitleLabel
{
    if (_goodsTitleLabel == nil) {
        
        _goodsTitleLabel = [[UILabel alloc] init];
        [_goodsTitleLabel setFont:FONT15];
        _goodsTitleLabel.textColor = [UIColor blackColor];
    }
    return _goodsTitleLabel;
}

- (UILabel *)goodsDescLabel
{
    if (_goodsDescLabel == nil) {
        
        _goodsDescLabel= [[UILabel alloc] init];
        [_goodsDescLabel setFont:FONT15];
        _goodsDescLabel.textColor = [UIColor grayColor];
    }
    
    return _goodsDescLabel;
}

- (UIImageView *)rightArrow1ImgView
{
    if (_rightArrow1ImgView == nil) {
        
        _rightArrow1ImgView = [[UIImageView alloc] init];
        
    }
    return _rightArrow1ImgView;
}
- (UIView *)goodsMessageView
{
    if (_goodsMessageView == nil) {
        
        _goodsMessageView = [[UIView alloc] init];
        
        
    }
    
//    [_goodsMessageView addSubview:self.goodsTitleLabel];
//    [_goodsMessageView addSubview:self.goodsDescLabel];
//    [_goodsDescLabel addSubview:self.rightArrow1ImgView];
    
    
    
    return _goodsMessageView;
}

- (UILabel *)prePriceLabel
{
    if (_prePriceLabel == nil) {
        
        _prePriceLabel = [[UILabel alloc] init];
        
        _prePriceLabel.font = FONT15;
        
        _prePriceLabel.textColor = [UIColor grayColor];
    }
    return _prePriceLabel;
}

- (UIImageView *)prePriceLineImgView
{
    if (_prePriceLineImgView == nil) {
        
        _prePriceLineImgView = [[UIImageView alloc] init];
        
        [_prePriceLineImgView setBackgroundColor:[UIColor grayColor]];
    }
    return _prePriceLineImgView;
}

- (UILabel *)goodsNumLabel
{
    if (_goodsNumLabel == nil) {
        
        _goodsNumLabel = [[UILabel alloc] init];
        _goodsNumLabel.font = FONT16;
        _goodsNumLabel.textColor = [UIColor blackColor];
    }
    return _goodsNumLabel;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        
        _addBtn = [[UIButton alloc] init];
    }
    return _addBtn;
}

- (UIButton *)minusBtn
{
    if (_minusBtn == nil) {
        
        _minusBtn = [[UIButton alloc] init];
    }
    
    return _minusBtn;
}

- (UILabel *)huiPriceLabel
{
    if (_huiPriceLabel == nil) {
        
        _huiPriceLabel = [[UILabel alloc] init];
        
        _huiPriceLabel.font = FONT15;
        
        _huiPriceLabel.textColor = GLOBAL_RedColor;
    }
    return _huiPriceLabel;
}

- (UILabel *)lastGoodsNumLabel
{
    if (_lastGoodsNumLabel == nil) {
        
        _lastGoodsNumLabel = [[UILabel alloc] init];
        
        _lastGoodsNumLabel.font = FONT15;
        _lastGoodsNumLabel.textColor = [UIColor grayColor];
        _lastGoodsNumLabel.textAlignment= NSTextAlignmentRight;
    }
    
    return _lastGoodsNumLabel;
}
- (UILabel *)endTimeLabel
{
    if (_endTimeLabel == nil) {
    
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.font = FONT15;
        _endTimeLabel.textColor = [UIColor blackColor];
    }
    return _endTimeLabel;
}

- (UIView *)buyRecordView
{
    if (_buyRecordView == nil) {
        
        _buyRecordView = [[UIView alloc] init];
    }
    
    return _buyRecordView;
}

- (UILabel *)buyRecordLabel
{
    if (_buyRecordLabel == nil) {
        
        _buyRecordLabel = [[UILabel alloc] init];
        _buyRecordLabel.font = FONT15;
        _buyRecordLabel.textColor = [UIColor blackColor];
    }
    
    return _buyRecordLabel;
}

- (UIImageView *)rightArrow2ImgView
{
    if (_rightArrow2ImgView == nil) {
        
        _rightArrow2ImgView = [[UIImageView alloc] init];
    }
    
    return _rightArrow2ImgView;
}

@end
