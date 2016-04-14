//
//  HuiGoodsCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiGoodsCell.h"
#import "UIResponder+Router.h"

#define kImgGap (SCREEN_WIDTH==320.0 ? 5:5)
#define kImgWidth ((SCREEN_WIDTH - 2 *kGap -2 * kImgGap)/3.0f)
@implementation HuiGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftImgView = [[homeGoodsView alloc] initWithFrame:CGRectMake(kGap, 0, kImgWidth, kImgWidth)];
        [self addSubview:_leftImgView];
        
        _middleImgView = [[homeGoodsView alloc] initWithFrame:CGRectMake(kGap + kImgWidth + kImgGap, 0, kImgWidth, kImgWidth)];
        [self addSubview:_middleImgView];
        
        _rightImgView = [[homeGoodsView alloc] initWithFrame:CGRectMake(kGap + 2 *kImgWidth +2* kImgGap, 0, kImgWidth, kImgWidth)];
        [self addSubview:_rightImgView];
    }
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(leftTapClick)];
    [_leftImgView addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(middleTapClick)];
    [_middleImgView addGestureRecognizer:middleTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapClick)];
    [_rightImgView addGestureRecognizer:rightTap];
    return self;
}

- (void)cellFillLeftModel:(goodsDetailInfo *)leftModel leftRow:(NSUInteger)leftRow andMiddleModel:(goodsDetailInfo *)middleModel middletRow:(NSUInteger)middleRow andRightModel:(goodsDetailInfo *)rightModel rightRow:(NSUInteger)rightRow
{
    _leftRow = leftRow;
    _middleRow = middleRow;
    _rightRow = rightRow;
    
    [_leftImgView viewFillGoodsDetailInfo:leftModel];
    
    if (middleModel == nil)
    {
        _middleImgView.hidden = YES;
    }else
    {
        [_middleImgView viewFillGoodsDetailInfo:middleModel];
    }
    
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
    return kImgWidth + 60;
   
}


- (void)leftTapClick
{
    //    NSLog(@"leftTapClick %lu",(unsigned long)_leftRow);
    [super routerEventWithName:GHHOMEGOODS_ROUTEREVENT userInfo:@{@"row":[NSString stringWithFormat:@"%d",(int)_leftRow]}];
    
}

- (void)middleTapClick
{
    [super routerEventWithName:GHHOMEGOODS_ROUTEREVENT userInfo:@{@"row":[NSString stringWithFormat:@"%d",(int)_middleRow]}];
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
