//
//  ProjectListView.m
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectListView.h"
#import <UIImageView+AFNetworking.h>
@implementation ProjectListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width * 0.7)];
        [self addSubview:_imgView];
        
        _projectName = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width * 0.7 + 5, frame.size.width , 20)];
        _projectName.font= FONT18;
        [self addSubview:_projectName];
        
        _projectDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width * 0.7 +20 + 5,  frame.size.width, frame.size.height * 0.3 - 20)];
        _projectDesc.font = FONT14;
        _projectDesc.textColor = [UIColor grayColor];
        _projectDesc.numberOfLines = 0;
        [self addSubview:_projectDesc];
    
    }
    
    return self;
}

- (void)viewFillWithProjectListInfo:(ProjectListInfo *)info
{
    [_imgView setImageWithURL:[NSURL URLWithString:info.projectImgUrl] placeholderImage:GHSMALLIMAGE];
    
    _projectName.text = info.projectName;
    
    _projectDesc.text = info.projectDesc;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
