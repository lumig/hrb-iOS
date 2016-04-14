//
//  ActivityTableViewCell.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "UIImageView+AFNetworking.h"

#define kImgHeight [UIScreen mainScreen].bounds.size.width == 320 ? 100 : 120
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kCellGap  [UIScreen mainScreen].bounds.size.width == 320 ? 10 : 15



@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.showLabel];
        
        [self.contentView addSubview:self.atLabel];
        
        [self.contentView addSubview:self.leftImgView];
        
        [self.contentView addSubview:self.rightImgView];
        
        
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftImgClick)];
        
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightImgClcik)];
        
        [self.leftImgView addGestureRecognizer:leftTap];
        [self.rightImgView addGestureRecognizer:rightTap];
        
    }
    
    return self;
}

//- (UILabel *)showLabel
//{
//    if (_showLabel == nil) {
//        _showLabel = [[UILabel alloc] init];
//        _showLabel.frame = CGRectMake(15, 0, 60, 30);
//        _showLabel.text = @"最近一周";
//        _showLabel.font = [UIFont systemFontOfSize:13];
//        _showLabel.textColor = [UIColor grayColor];
//        
//    }
//    return _showLabel;
//}

- (ATLabel *)atLabel
{
    if (_atLabel == nil) {
        
        _atLabel = [[ATLabel alloc] initWithFrame:CGRectMake(75, 0, 150, 30)];
        _atLabel.font = FONT15;
    }
    
    return _atLabel;
}

- (UIImageView *)leftImgView
{
    if (_leftImgView == nil) {
        
        _leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.showLabel.frame),(kScreenWidth) / 2.0 -2, kImgHeight)];
        _leftImgView.backgroundColor = [UIColor clearColor];
        _leftImgView.userInteractionEnabled = YES;
        
        _leftImgView.backgroundColor = [UIColor redColor];
    }
    return _leftImgView;
}

- (UIImageView *)rightImgView
{
    if (_rightImgView == nil) {
        
        _rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImgView.frame) + 4, CGRectGetMaxY(self.showLabel.frame), (kScreenWidth) / 2.0, kImgHeight)];
        
        _rightImgView.backgroundColor = [UIColor clearColor];
        _rightImgView.userInteractionEnabled = YES;
        
        _rightImgView.backgroundColor = [UIColor greenColor];
    }
    return _rightImgView;
}

- (void)leftImgClick
{
    [self routerForIndex:@0];
}

- (void)rightImgClcik
{
    [self routerForIndex:@1];
}

- (void)routerForIndex:(NSNumber *)index
{
    [super routerEventWithName:GHActivtity_ROUTEREVENT userInfo:@{@"index":index}];
}

+(CGFloat)cellHeightForModel:(ActivityModel *)model
{
    return (kImgHeight);
}

- (void)fetchActivityModel:(ActivityModel *)model
{
    [self.atLabel animateWithWords:model.atLabelArray forDuration:2.0];
    [self.leftImgView setImageWithURL:[NSURL URLWithString:model.leftImgUrl ] placeholderImage:GHSMALLIMAGE];
    [self.rightImgView setImageWithURL:[NSURL URLWithString:model.rightImgUrl] placeholderImage:GHSMALLIMAGE];
    
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
