//
//  BuyRecordsTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BuyRecordsTableViewCell.h"

@implementation BuyRecordsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellFillWithBuyDateModel:(BuyDateModel *)model
{
    if ([model.type intValue] == -1) {
        [self setTextIsBlack:YES];
        self.userLabel.text = @"用户";
        self.huiCodeLabel.text = @"惠金币";
//        self.amoutLabel.text = @"金额(元)";
        self.buyDateLabel.text = @"换购日期";
    }
    else
    {
        [self setTextIsBlack:NO];
        self.userLabel.text = model.userName;
        self.huiCodeLabel.text = [NSString stringWithFormat:@"%@",model.huiCode];
//        self.amoutLabel.text = model.amountStr;
        self.buyDateLabel.text = model.buyDate;
    }
}

- (void)setTextIsBlack:(BOOL)isBlack
{
    if (isBlack)
    {
        self.userLabel.textColor = [UIColor blackColor];
        self.huiCodeLabel.textColor = [UIColor blackColor];
        self.amoutLabel.textColor = [UIColor blackColor];
        self.buyDateLabel.textColor = [UIColor blackColor];
        
    }else
    {
        self.userLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.huiCodeLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.amoutLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.buyDateLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        
        self.buyDateLabel.font = FONT16;
        self.userLabel.font = FONT16;
    }
}



+(CGFloat)cellHeight
{
    return 44;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
