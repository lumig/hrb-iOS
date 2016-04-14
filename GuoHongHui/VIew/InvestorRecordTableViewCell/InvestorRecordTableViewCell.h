//
//  InvestorRecordTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "investorRecordModel.h"
@interface InvestorRecordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *investorLabel;

@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;

@property (weak, nonatomic) IBOutlet UILabel *recordLabel;

- (void)cellFillWithInvestorRecordModel:(investorRecordModel *)model;

+(CGFloat)cellHeight;

@end
