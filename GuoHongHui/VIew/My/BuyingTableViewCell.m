//
//  BuyingTableViewCell.m
//  GuoHongHui
//
//  Created by LuMig on 15/6/23.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BuyingTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "GHStringManger.h"

#import "OrderModel.h"
#define GoodsImgHeight  (SCREEN_WIDTH==320.0 ? 80:100)

#define LeftGap 15.0

@implementation BuyingTableViewCell

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
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.orderIDLabel];
//        [self addSubview:self.cellView];

        [self addSubview:self.firstGoodsImgView];
        [self addSubview:self.secondGoodsImgView];
        [self addSubview:self.goodsNumLabel];
        [self addSubview:self.smallPointImgView];
        [self addSubview:self.orderTotalLabel];
        [self addSubview:self.rightBtn];
        
        [self addSubview:self.topLineView];
        [self addSubview:self.bottomLineView];
        
        [self addSubview:self.bottomImgView];
    }
    
    return self;
}


#pragma mark --
#pragma mark -- event response

- (void)rightBtnClick:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(buyingButtonClickWithIndex:)]) {
        
        [self.delegate buyingButtonClickWithIndex:btn.tag];
    }
}

- (void)fillWithOrderModel:(OrderModel *)info indexRow:(NSInteger)index
{
    [self.orderIDLabel setText:[NSString stringWithFormat:@"订单号：%@",info.orderId]];
    
    if (info.orderArray != nil) {
        
        if (info.orderArray.count < 2) {
            
            [self.firstGoodsImgView setFrame:CGRectMake(LeftGap, LeftGap + 40, GoodsImgHeight, GoodsImgHeight)];
           
            NSDictionary *dict = info.orderArray[0];
            
            [self.firstGoodsImgView setImageWithURL:[NSURL URLWithString: [dict objectForKey:@"productIdUrl"]] placeholderImage:GHSMALLIMAGE];
            
            _goodsNumOffset = LeftGap * 2 + GoodsImgHeight;
        }
        else
        {
            [self.firstGoodsImgView setFrame:CGRectMake(LeftGap, LeftGap + 40, GoodsImgHeight, GoodsImgHeight)];
            NSDictionary *dict = info.orderArray[0];
            [self.firstGoodsImgView setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"productIdUrl"]] placeholderImage:GHSMALLIMAGE];
            
            [self.secondGoodsImgView setFrame:CGRectMake(CGRectGetMaxX(self.firstGoodsImgView.frame) + LeftGap, LeftGap + 40, GoodsImgHeight, GoodsImgHeight)];
            NSDictionary *dict1 = info.orderArray[1];
            [self.secondGoodsImgView setImageWithURL:[NSURL URLWithString:[dict1 objectForKey:@"productIdUrl"]] placeholderImage:GHSMALLIMAGE];
            
            _goodsNumOffset = LeftGap * 3 + 2 * (GoodsImgHeight);
        }
    }
    self.firstGoodsImgView.tag = index;
    self.secondGoodsImgView.tag = index;
    
    self.goodsNumLabel.frame = CGRectMake(_goodsNumOffset, CGRectGetMaxY(_orderIDLabel.frame) + 20 + (GoodsImgHeight - 20)/2.0, [GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 20) font:FONT15 text:[NSString stringWithFormat:@"X %ld款商品  ",info.orderArray.count]].width, 20);
    
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"X %ld款商品  ",info.orderArray.count]];
    
    
    self.smallPointImgView.frame = CGRectMake(CGRectGetMaxX(self.goodsNumLabel.frame), CGRectGetMaxY(_orderIDLabel.frame) + 20 + (GoodsImgHeight - 15)/2.0, 10, 15);
    
    [self.smallPointImgView setImage:[UIImage imageNamed:@"i_arrow_gray_right.png"]];
    
    [self.orderTotalLabel setFrame:CGRectMake(LeftGap, CGRectGetMaxY(self.firstGoodsImgView.frame) + 20, 200, 20)];
    [self.orderTotalLabel setText:[NSString stringWithFormat:@"订单金额：%@",info.orderSum]];
    
    [self.rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 80 -15, CGRectGetMaxY(self.firstGoodsImgView.frame) + 20, 80, 25)];
    
    self.rightBtn.tag = index;
    
    [self.rightBtn setTitle:@"去支付" forState:UIControlStateNormal ];
    
    //    _cellHeight = 120 + GoodsImgHeight;
    //
    //    [self.bottomLineView setFrame:CGRectMake(0, _cellHeight - 1, SCREEN_WIDTH, 1)];

}

- (void)fillWithOrderInfo:(OrderInfo *)info
{
//    [self.topLineView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    
    [self.orderIDLabel setText:[NSString stringWithFormat:@"订单号：%@",info.orderID]];
    
    if (info.imgArray != nil) {
        
        if (info.imgArray.count < 2) {
            
            [self.firstGoodsImgView setFrame:CGRectMake(LeftGap, LeftGap + 40, GoodsImgHeight, GoodsImgHeight)];
            
            [self.firstGoodsImgView setImageWithURL:[NSURL URLWithString:info.imgArray[0]] placeholderImage:GHSMALLIMAGE];
            
            _goodsNumOffset = LeftGap * 2 + GoodsImgHeight;
        }
        else
        {
            [self.firstGoodsImgView setFrame:CGRectMake(LeftGap, LeftGap + 40, GoodsImgHeight, GoodsImgHeight)];
            [self.firstGoodsImgView setImageWithURL:[NSURL URLWithString:info.imgArray[0]] placeholderImage:GHSMALLIMAGE];
            
            [self.secondGoodsImgView setFrame:CGRectMake(CGRectGetMaxX(self.firstGoodsImgView.frame) + LeftGap, LeftGap + 40, GoodsImgHeight, GoodsImgHeight)];
            [self.secondGoodsImgView setImageWithURL:[NSURL URLWithString:info.imgArray[1]] placeholderImage:GHSMALLIMAGE];
            
            _goodsNumOffset = LeftGap * 3 + 2 * (GoodsImgHeight);
        }
    }
    
    self.goodsNumLabel.frame = CGRectMake(_goodsNumOffset, CGRectGetMaxY(_orderIDLabel.frame) + 20 + (GoodsImgHeight - 20)/2.0, [GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 20) font:FONT15 text:[NSString stringWithFormat:@"X %@款商品  ",info.goodsNum]].width, 20);
    
    [self.goodsNumLabel setText:[NSString stringWithFormat:@"X %@款商品  ",info.goodsNum]];
    
    
    self.smallPointImgView.frame = CGRectMake(CGRectGetMaxX(self.goodsNumLabel.frame), CGRectGetMaxY(_orderIDLabel.frame) + 20 + (GoodsImgHeight - 15)/2.0, 10, 15);
    
    [self.smallPointImgView setImage:[UIImage imageNamed:@"i_arrow_gray_right.png"]];
    
    [self.orderTotalLabel setFrame:CGRectMake(LeftGap, CGRectGetMaxY(self.firstGoodsImgView.frame) + 20, 200, 20)];
    [self.orderTotalLabel setText:[NSString stringWithFormat:@"订单金额：¥%@",info.orderTotalNum]];
    
    [self.rightBtn setFrame:CGRectMake(SCREEN_WIDTH - 80 -15, CGRectGetMaxY(self.firstGoodsImgView.frame) + 20, 80, 25)];
    
    [self.rightBtn setTitle:@"去支付" forState:UIControlStateNormal ];

//    _cellHeight = 120 + GoodsImgHeight;
//    
//    [self.bottomLineView setFrame:CGRectMake(0, _cellHeight - 1, SCREEN_WIDTH, 1)];
}

- (void)imgViewClick{
    if ([self.delegate respondsToSelector:@selector(cellImgViewClick)]) {
        
        [self.delegate cellImgViewClick];
    }
}

#pragma mark --
#pragma mark -- setter and getter

- (UIView *)topLineView
{
    if(_topLineView ==nil)
    {
        _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _topLineView.backgroundColor = [UIColor grayColor];
        _topLineView.alpha = 0.2;
        
    }
    
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, GoodsImgHeight + 119, SCREEN_WIDTH, 1)];
        _bottomLineView.backgroundColor = [UIColor grayColor];
        _bottomLineView.alpha = 0.4;
    }
    
    return _bottomLineView;
}

- (UILabel *)orderIDLabel
{
    if (_orderIDLabel == nil) {
        
        _orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftGap, LeftGap, 300, 20)];
        _orderIDLabel.textColor = [UIColor grayColor];
        _orderIDLabel.font = FONT15;
        
    }
    
    return _orderIDLabel;
    
}

- (UIView *)cellView
{
    if (_cellView == nil) {
        
        _cellView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_orderIDLabel.frame) + 20, SCREEN_WIDTH, GoodsImgHeight)];
        _cellView.userInteractionEnabled = YES;
    }
    
    [_cellView addSubview:_firstGoodsImgView];
    [_cellView addSubview:_secondGoodsImgView];
    [_cellView addSubview:_smallPointImgView];
    return _cellView;
}


- (UIImageView *)firstGoodsImgView
{
    if (_firstGoodsImgView ==nil) {
        _firstGoodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftGap, 0, GoodsImgHeight, GoodsImgHeight)];
//        _firstGoodsImgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewClick)];
        [_firstGoodsImgView addGestureRecognizer:tap];
    }
    return _firstGoodsImgView;
}

- (UIImageView *)secondGoodsImgView
{
    if (_secondGoodsImgView == nil) {
        
        _secondGoodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_firstGoodsImgView.frame) + 15.0f, 0, GoodsImgHeight ,GoodsImgHeight )];
//        _secondGoodsImgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewClick)];
        [_secondGoodsImgView addGestureRecognizer:tap];
    }
    return _secondGoodsImgView;
}


- (UILabel *)goodsNumLabel
{
    if (_goodsNumLabel ==nil) {
        
        _goodsNumLabel = [[UILabel alloc] init];
        _goodsNumLabel.textColor = [UIColor blackColor];
        _goodsNumLabel.font = FONT15;
        
    }
    
    return _goodsNumLabel;
}
- (UIImageView *)smallPointImgView
{
    if (_smallPointImgView == nil) {
        
        _smallPointImgView = [[UIImageView alloc] init];
        _smallPointImgView.userInteractionEnabled = YES;
    }
    
    return _smallPointImgView;
}

- (UILabel *)orderTotalLabel
{
    if (_orderTotalLabel == nil) {
        
        _orderTotalLabel = [[UILabel alloc] init];
        _orderTotalLabel.textColor = [UIColor blackColor];
        _orderTotalLabel.font = FONT15;
    }
    
    return _orderTotalLabel;
}

- (UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        _rightBtn = [[UIButton alloc] init];
        
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.layer.cornerRadius = 5;
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.layer.borderWidth = 1;
        _rightBtn.layer.borderColor = [GLOBAL_RedColor CGColor];
        [_rightBtn setTitleColor:GLOBAL_RedColor forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = FONT14;
    }
    
    return _rightBtn;
}

+ (CGFloat)heightForCell
{

    return  GoodsImgHeight + 135;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

-(UIImageView *)bottomImgView
{
    if (_bottomImgView == nil) {
        
        _bottomImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, GoodsImgHeight + 120, SCREEN_WIDTH, 15)];
        [_bottomImgView setBackgroundColor:GLOBAL_GrayColor];
    }
    return _bottomImgView;
}



@end
