//
//  ProjectListTableViewCell.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectListInfo.h"


@interface ProjectListTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *createTimeLabel;
@property(nonatomic,strong)UILabel *descLabel;
@property(nonatomic,strong)UIImageView *tagImgView;
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UIImageView *lineImgView;

//+(CGFloat)hightForDescription:(NSString *)desc;

+(CGFloat)hightForCell;

- (void)fillCellWithProjectListInfo:(ProjectListInfo *)info;


@end
