//
//  InvestmentTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/6/30.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "productModel.h"

@interface InvestmentTableViewCell : UITableViewCell

//本金
@property (weak, nonatomic) IBOutlet UILabel *principalLabel;

//利息
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
//利率
@property (weak, nonatomic) IBOutlet UILabel *rateLable;

//购买日期
@property (weak, nonatomic) IBOutlet UILabel *purchaseLabel;

//收益日期
@property (weak, nonatomic) IBOutlet UILabel *earingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLineView;

- (void)cellFillWithProductModel:(productModel *)model;

+(CGFloat)cellHeight;

@end
