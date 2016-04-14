//
//  MyBtnListTableViewCell.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/19.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "MyBtnListTableViewCell.h"
#import "HuiOrderViewController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width/2.0f

@implementation MyBtnListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray andTitleArray:(NSArray *)titleArray andStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _btnListView = [[BtnListView alloc] initWithFrame:frame andImageArray:imageArray andTitleArray:titleArray];
        _btnListView.delegate = self;
        
        [self addSubview:_btnListView];
        
    }
    
    return self;
}


#pragma mark --
#pragma mark -- event response

- (void)fetchWithMyBtnListTableViewCellWithImageArray:(NSArray *)imageArray andTitleArray:(NSArray *)titleArray
{
    _btnListView = [[BtnListView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kWidth) andImageArray:imageArray andTitleArray:titleArray];
    
}




+(CGFloat)getCellHeight
{
    return kWidth;
}


- (void)btnClickWith:(UIButton *)btn
{
//    NSLog(@"the btn is click %ld",btn.tag);
    
    if ([self.delegate respondsToSelector:@selector(btnListClick:)]) {
        
        [self.delegate btnListClick:btn.tag];
    }
   
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
