//
//  RecipentAddressTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//收货人地址cell

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface RecipentAddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;


@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;



- (void)cellFillWithAddressModel:(AddressModel *)model;

+ (CGFloat)cellHeight;

@end
