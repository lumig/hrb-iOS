//
//  MyBaoListTableViewCell.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/19.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "MyBaoListTableViewCell.h"


@implementation MyBaoListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)fillCellWithMyBaoInfo:(myBaoInfo *)info
{
    
    [_lefImgView setImage:[UIImage imageNamed:info.imageStr]];
    
    self.descLabel.text = info.nameStr;
    
    if (info.moneyStr !=nil) {
        self.numLabel.text = [NSString stringWithFormat:@"%@元",info.moneyStr];
    }
    else
    {
        self.numLabel.text = [NSString stringWithFormat:@"%d元",0];

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
