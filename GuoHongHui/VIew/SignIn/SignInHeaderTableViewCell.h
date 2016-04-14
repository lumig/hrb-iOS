//
//  SignInHeaderTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//签到页头部
#import <UIKit/UIKit.h>

@interface SignInHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *huiCodeLabel;

@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

//已签到
- (void)idDoSignIn:(BOOL)isDo;

- (void)cellFillWithHuiCode:(NSNumber *)huiCode;

@end
