//
//  SignInListTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//签到页下面列表
#import <UIKit/UIKit.h>
#import "SignInModel.h"

@interface SignInListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *huiAddLabel;

@property (weak, nonatomic) IBOutlet UILabel *huiReduceLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@property (weak, nonatomic) IBOutlet UILabel *createLabel;


- (void)cellFillWithSignInModel:(SignInModel *)model;

+(CGFloat)cellHeight;

@end
