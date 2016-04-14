//
//  holdingTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "holdingTableViewCell.h"

@implementation holdingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.waitingBTN.layer.cornerRadius = 6;
    self.waitingBTN.layer.masksToBounds = YES;
    
    self.waitingBTN.enabled = NO;
    [self.waitingBTN setTitle:@"等待收益" forState:UIControlStateNormal];
    
    
    [self.bottomImgView setBackgroundColor:GLOBAL_GrayColor];
}


- (void)cellFillWithProductModel:(productModel *)model
{
    [self.productNameLabel setText:model.productName];
    [self.purchaseDateLabel setText:model.purchaseDate];
    
    [self.earningDateLabel setText:model.earningDate];
    [self.rateLabel setText:[NSString stringWithFormat:@"%@%%",model.rate]];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

+ (CGFloat)cellHeight
{
    return 150;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
