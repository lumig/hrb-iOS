//
//  ShopCarFooterTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsDetailInfo.h"

@protocol ShopCarFooterTableViewCellDelegate <NSObject>

- (void)selectedAllBtnClickWithIsSelected:(BOOL)isSelected;

- (void)toAccountBtnClick;


@end

@interface ShopCarFooterTableViewCell : UITableViewCell

@property(nonatomic,assign)id<ShopCarFooterTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *acountBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectedAllBtn;

@property(nonatomic,assign)BOOL isSelected;

+ (CGFloat)cellHeight;

- (IBAction)selectAllBtnClick:(id)sender;

- (IBAction)accountBtnClick:(id)sender;
@end
