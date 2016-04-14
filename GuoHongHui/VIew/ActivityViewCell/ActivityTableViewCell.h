//
//  ActivityTableViewCell.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATLabel.h"
#import "ActivityModel.h"
#import "UIResponder+Router.h"

@interface ActivityTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *showLabel;
@property(nonatomic,strong)ATLabel *atLabel;
@property(nonatomic,strong)UIImageView *leftImgView;
@property(nonatomic,strong)UIImageView *rightImgView;


- ( void)fetchActivityModel:(ActivityModel *)model;

+ (CGFloat)cellHeightForModel:(ActivityModel *)model;

@end
