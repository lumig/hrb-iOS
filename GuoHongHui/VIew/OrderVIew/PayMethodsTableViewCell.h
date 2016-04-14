//
//  PayMethodsTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMethodsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *totalHuiCodeLabel;

+(CGFloat)cellHeight;

@end
