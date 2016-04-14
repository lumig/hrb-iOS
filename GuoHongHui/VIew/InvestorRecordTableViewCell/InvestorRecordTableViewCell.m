//
//  InvestorRecordTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "InvestorRecordTableViewCell.h"

@implementation InvestorRecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellFillWithInvestorRecordModel:(investorRecordModel *)model
{
    if ([model.type intValue] == -1) {
        [self setTextIsBlack:YES];
        self.investorLabel.text = @"投资人";
        self.amoutLabel.text = @"金额(元)";
        self.recordLabel.text = @"投资日期";
    }
    else
    {
        [self setTextIsBlack:NO];
        self.investorLabel.text = model.investor;
        self.amoutLabel.text = [NSString stringWithFormat:@"%@",model.amountMoney];
        self.recordLabel.text = model.recordStr;
    }
    
}

- (void)setTextIsBlack:(BOOL)isBlack
{
    if (isBlack)
    {
        self.investorLabel.textColor = [UIColor blackColor];
        self.amoutLabel.textColor = [UIColor blackColor];
        self.recordLabel.textColor = [UIColor blackColor];
        
    }else
    {
        self.investorLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.amoutLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.recordLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        
        self.investorLabel.font = FONT14;
        self.amoutLabel.font = FONT14;
        self.recordLabel.font = FONT14;
    }
}


+ (CGFloat)cellHeight
{
    return 44;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
