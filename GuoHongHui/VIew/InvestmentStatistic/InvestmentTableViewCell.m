//
//  InvestmentTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/6/30.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "InvestmentTableViewCell.h"

@implementation InvestmentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.bottomLineView setBackgroundColor:GLOBAL_GrayColor];
}


- (void)cellFillWithProductModel:(productModel *)model
{
    [self.principalLabel setText:[NSString stringWithFormat:@"%@元",model.principal]];
    [self.rateLable setText:[NSString stringWithFormat:@"%@%%",model.rate]];
    [self.interestLabel setText:[NSString stringWithFormat:@"%@元",model.interest]];
   
    [self.purchaseLabel setText:model.purchaseDate];
    
    [self.earingLabel setText:model.earningDate];
    
}

+(CGFloat)cellHeight
{
    return 140;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
