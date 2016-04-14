//
//  holdingTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "productModel.h"

@interface holdingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *purchaseDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *earningDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet UIButton *waitingBTN;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImgView;

- (void)cellFillWithProductModel:(productModel *)model;

+ (CGFloat)cellHeight;

@end
