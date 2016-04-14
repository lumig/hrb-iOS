//
//  BuyRecordsTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//换购记录

#import <UIKit/UIKit.h>
#import "BuyDateModel.h"


@interface BuyRecordsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@property (weak, nonatomic) IBOutlet UILabel *huiCodeLabel;
//金额
@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;

@property (weak, nonatomic) IBOutlet UILabel *buyDateLabel;

- (void)cellFillWithBuyDateModel:(BuyDateModel *)model;

+(CGFloat)cellHeight;

@end
