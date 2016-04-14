//
//  SignInHeaderTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "SignInHeaderTableViewCell.h"

@implementation SignInHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.titleBtn.titleLabel.numberOfLines = 0;
    self.titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleBtn.layer.cornerRadius = 6;
    self.titleBtn.layer.masksToBounds = YES;
    
   
    [self.titleBtn setTitle:@"签到\n送10惠金币" forState:UIControlStateNormal];
}

- (void)cellFillWithHuiCode:(NSNumber *)huiCode
{
    [self.huiCodeLabel setText:[NSString stringWithFormat:@"%@",huiCode]];
}

- (void)idDoSignIn:(BOOL)isDo
{
    if (isDo) {
        self.titleBtn.enabled = NO;
        self.titleBtn.backgroundColor = [UIColor grayColor];
        
        [self.titleBtn setTitle:@"今天10惠金币已领明天继续哦~" forState:UIControlStateNormal];
        self.titleBtn.titleLabel.font = FONT14;
        [self.titleBtn.titleLabel setTextColor:[UIColor whiteColor]];
        
    }else
    {
        self.titleBtn.enabled = YES;
        self.titleBtn.backgroundColor = GLOBAL_RedColor;
        [self.titleBtn setTitle:@"签到\n送10惠金币" forState:UIControlStateNormal];
        self.titleBtn.titleLabel.font = FONT15;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
