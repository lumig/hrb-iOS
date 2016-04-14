//
//  GoodsMessTableViewCell.h
//  hrb-iOS
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsMessTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *huiPriceLabel;

+ (CGFloat)cellHeight;

@end
