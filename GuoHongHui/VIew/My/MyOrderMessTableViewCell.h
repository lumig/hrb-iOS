//
//  MyOrderMessTableViewCell.h
//  hrb-iOS
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderMessTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *logisticsNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *logisticsLabel;

+ (CGFloat)cellHeight;

@end
