//
//  HeaderButtonView.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HeaderButtonViewDelegate <NSObject>

@optional

- (void)headerButtonClick:(NSUInteger)index;

@end

@interface HeaderButtonView : UIView
{
    UIImageView *_lineImageView;
    UIImageView *_bgImageView;
    
    UIButton    *_currentButton;
    
    float     _buttonWidth;
    
    UIColor     *_selectColor;
    UIColor     *_unSelectColor;
    
    NSArray    *_imageArray;
    NSMutableArray *_buttonArray;
}


@property(assign,nonatomic)id<HeaderButtonViewDelegate> delegate;


- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;

- (void)currentSelectButton:(NSUInteger)index;

@end
