//
//  ProjectListCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectListCell.h"
#import "UIResponder+Router.h"


#define kImgGap (SCREEN_WIDTH==320.0 ? 5:10)
#define kImgWidth ((SCREEN_WIDTH - 2 *kGap - kImgGap)/2.0f)
@implementation ProjectListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _leftImgView = [[ProjectListView alloc] initWithFrame:CGRectMake(kGap, 0, kImgWidth, kImgWidth + 30)];
        [self addSubview:_leftImgView];
        
        _rightImgView = [[ProjectListView alloc] initWithFrame:CGRectMake(kGap + kImgWidth + kImgGap, 0, kImgWidth, kImgWidth + 30)];
        [self addSubview:_rightImgView];
    }
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(leftTapClick)];
    [_leftImgView addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapClick)];
    [_rightImgView addGestureRecognizer:rightTap];
    
    return self;
}

- (void)cellFillLeftModel:(ProjectListInfo *)leftModel leftRow:(NSUInteger)leftRow rightModel:(ProjectListInfo *)rightModel rightRow:(NSUInteger)rightRow
{
    _leftRow = leftRow;
    _rightRow = rightRow;
    
    [_leftImgView viewFillWithProjectListInfo:leftModel];
    
    
    if (rightModel == nil)
    {
        _rightImgView.hidden = YES;
    }else
    {
        [_rightImgView viewFillWithProjectListInfo:rightModel];
    }
}

+ (CGFloat)cellHeight
{
    return kImgWidth + 20;
}

- (void)leftTapClick
{
    [super routerEventWithName:GHPROJECTLIST_ROUTEREVENT userInfo:@{@"row":[NSString stringWithFormat:@"%d",(int)_leftRow]}];
    
}

- (void)rightTapClick
{
    [super routerEventWithName:GHPROJECTLIST_ROUTEREVENT userInfo:@{@"row":[NSString stringWithFormat:@"%d",(int)_rightRow]}];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
