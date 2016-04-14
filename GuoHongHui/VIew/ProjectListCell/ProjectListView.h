//
//  ProjectListView.h
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectListInfo.h"

@interface ProjectListView : UIView

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UILabel *projectName;

@property(nonatomic,strong)UILabel *projectDesc;

- (void)viewFillWithProjectListInfo:(ProjectListInfo *)info;

@end
