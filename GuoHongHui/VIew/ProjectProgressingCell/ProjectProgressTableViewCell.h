//
//  ProjectProgressTableViewCell.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectProgressInfo.h"
#import "ProjectProgressingModel.h"
#import "SDPhotoGroup.h"
#import "SDPhotoItem.h"
#import "GHStringManger.h"


@interface ProjectProgressTableViewCell : UITableViewCell<SDPhotoGroupDelegate>

@property(nonatomic,strong)UIImageView *projectIcon;
@property(nonatomic,strong)UILabel *projectName;
@property(nonatomic,strong)UILabel *projectDesc;
@property(nonatomic,strong)UILabel *publicTime;
@property(nonatomic,strong)SDPhotoGroup *photoGroup;
//分割线
@property(nonatomic,strong)UIImageView *lineImgView;

//photo距离cell顶端的高度
@property(nonatomic,assign)CGFloat photoGroupHeight;

- (void)fillCellWithProjectProgressInfo:(ProjectProgressInfo *)info;

+ (CGFloat)getCellHeightWithProjectProgressInfo:(ProjectProgressInfo *)info;

//获取photoGroup的高度
+ (CGFloat)getPhotoGroupWithProjectProgressInfo:(ProjectProgressInfo *)info;

+ (CGFloat)getTheDescHeightWithDescription:(NSString *)desc;
@end
