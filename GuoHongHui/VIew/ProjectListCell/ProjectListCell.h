//
//  ProjectListCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectListView.h"

#import "ProjectListInfo.h"

@interface ProjectListCell : UITableViewCell
@property(nonatomic,strong)ProjectListView *leftImgView;
@property(nonatomic,strong)ProjectListView *rightImgView;

@property(nonatomic,assign)NSUInteger leftRow;
@property(nonatomic,assign)NSUInteger rightRow;

- (void)cellFillLeftModel:(ProjectListInfo *)leftModel leftRow:(NSUInteger)leftRow rightModel:(ProjectListInfo *)rightModel rightRow:(NSUInteger)rightRow;

+ (CGFloat)cellHeight;

@end
