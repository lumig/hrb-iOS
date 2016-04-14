//
//  SendGoodsTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendGoodsTableViewCell : UITableViewCell

//物流选择
@property (weak, nonatomic) IBOutlet UILabel *expressChooseLabel;


@property (weak, nonatomic) IBOutlet UILabel *sendTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;

+ (CGFloat)cellHeight;
@end
