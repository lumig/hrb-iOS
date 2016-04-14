//
//  goodsCalculateTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//商品价格计算

#import <UIKit/UIKit.h>

@interface goodsCalculateTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalHuiCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPayLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastHuiCodeLabel;

+ (CGFloat )cellHeight;

@end
