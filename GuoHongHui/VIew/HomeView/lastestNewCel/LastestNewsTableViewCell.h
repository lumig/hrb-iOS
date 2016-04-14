//
//  LastestNewsTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LastestNewsModel.h"

@interface LastestNewsTableViewCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *imgView;

@property (strong, nonatomic)  UILabel *newsNameLabel;


@property (strong, nonatomic)  UILabel *newsDescLabel;
@property(nonatomic,strong)UIImageView *lineImgView;

- (void)cellFillWithLastestNewsModel:(LastestNewsModel *)model;

+ (CGFloat)cellHeight;


@end
