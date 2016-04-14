//
//  MyBtnListTableViewCell.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/19.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtnListView.h"
#import "ListButton.h"

@protocol MyBtnListTableViewCellDelegate <NSObject>

- (void)btnListClick:(NSInteger)index;

@end

@interface MyBtnListTableViewCell : UITableViewCell<BtnListViewDelegate>

@property(nonatomic,assign)id<MyBtnListTableViewCellDelegate> delegate;

@property(nonatomic,strong)BtnListView *btnListView;


- (void)fetchWithMyBtnListTableViewCellWithImageArray:(NSArray *)imageArray andTitleArray:(NSArray *)titleArray;

+(CGFloat)getCellHeight;

- (id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray andTitleArray:(NSArray *)titleArray andStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
