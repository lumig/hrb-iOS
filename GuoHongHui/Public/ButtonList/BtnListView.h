//
//  BtnListView.h
//  BtnListDemo
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 GUOHONGHUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BtnListViewDelegate <NSObject>

- (void)btnClickWith:(UIButton *)btn;

@end

@interface BtnListView : UIView

@property(nonatomic,assign)id<BtnListViewDelegate> delegate;


- (id)initWithFrame:(CGRect)rect andImageArray:(NSArray *)imageArray andTitleArray:(NSArray *)titleArray;

@end


