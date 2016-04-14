//
//  homeGoodsCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/16.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "homeGoodsCell.h"
#import "UIResponder+Router.h"
#define kImgGap (SCREEN_WIDTH==320.0 ? 5:5)
#define kImgWidth ((SCREEN_WIDTH - 2 *kGap - kImgGap)/2.0f)
@implementation homeGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftImgView = [[homeGoodsView alloc] initWithFrame:CGRectMake(kGap, 0, kImgWidth, kImgWidth)];
        [self addSubview:_leftImgView];
        
        _rightImgView = [[homeGoodsView alloc] initWithFrame:CGRectMake(kGap + kImgWidth + kImgGap, 0, kImgWidth, kImgWidth)];
        [self addSubview:_rightImgView];
    }
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(leftTapClick)];
    [_leftImgView addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapClick)];
    [_rightImgView addGestureRecognizer:rightTap];
    
    
    
    return self;
}

- (void)cellFillLeftModel:(goodsDetailInfo *)leftModel leftRow:(NSUInteger)leftRow rightModel:(goodsDetailInfo *)rightModel rightRow:(NSUInteger)rightRow
{
    _leftRow = leftRow;
    _rightRow = rightRow;
    
    [_leftImgView viewFillGoodsDetailInfo:leftModel];
    
    
    if (rightModel == nil)
    {
        _rightImgView.hidden = YES;
    }else
    {
        [_rightImgView viewFillGoodsDetailInfo:rightModel];
    }
}

+ (CGFloat)cellHeight
{
    return kImgWidth + 60+ 10;
}


- (void)leftTapClick
{
    //    NSLog(@"leftTapClick %lu",(unsigned long)_leftRow);
    [super routerEventWithName:GHHOMEGOODS_ROUTEREVENT userInfo:@{@"row":[NSString stringWithFormat:@"%d",(int)_leftRow]}];
    
}

- (void)rightTapClick
{
    //    NSLog(@"rightTapClick%lu",(unsigned long)_rightRow);
    [super routerEventWithName:GHHOMEGOODS_ROUTEREVENT userInfo:@{@"row":[NSString stringWithFormat:@"%d",(int)_rightRow]}];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
