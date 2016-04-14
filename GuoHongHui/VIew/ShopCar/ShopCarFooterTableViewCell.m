//
//  ShopCarFooterTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ShopCarFooterTableViewCell.h"

@implementation ShopCarFooterTableViewCell

- (void)awakeFromNib {
    self.acountBtn.layer.cornerRadius = 6;
    self.acountBtn.layer.masksToBounds = YES;
    self.acountBtn.backgroundColor = GLOBAL_RedColor;
    
}

- (IBAction)selectAllBtnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    BOOL flag = btn.selected;
    btn.selected = !flag;
    
    if ([self.delegate respondsToSelector:@selector(selectedAllBtnClickWithIsSelected:)]) {
        [self.delegate selectedAllBtnClickWithIsSelected:btn.selected];
    }
}

- (IBAction)accountBtnClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(toAccountBtnClick)]) {
        
        [self.delegate toAccountBtnClick];
    }
}

+ (CGFloat)cellHeight
{
    return 50;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
