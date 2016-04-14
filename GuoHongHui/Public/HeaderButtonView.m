//
//  HeaderButtonView.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HeaderButtonView.h"
#import "NSString+file.h"



@implementation HeaderButtonView


- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _selectColor = GLOBAL_RedColor;
        
        _unSelectColor = RGBACOLOR(159, 160, 160, 1);
        
        _buttonArray = [[NSMutableArray alloc]init];
        
        _imageArray = imageArray;
        
        NSUInteger tCount = [titleArray count];
        
        _buttonWidth = frame.size.width / tCount;
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
        
        
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _buttonWidth, 41)];
        
        _bgImageView.backgroundColor = [UIColor whiteColor];
        
        _bgImageView.userInteractionEnabled = YES;
        
        [self addSubview:_bgImageView];
        
        
        _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 41, _buttonWidth, 3)];
        
        _lineImageView.image = [UIImage imageNamed:@"通用底部.png"];
        
        [self addSubview:_lineImageView];
        
        float offX = 0.f;
        
        for (int i = 0; i < tCount; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(offX, 0, _buttonWidth, 42);
            
            button.titleLabel.font = FONT15;
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            
            [button setTitleColor:_unSelectColor forState:UIControlStateNormal];
            
            if ([imageArray count] > i)
            {
                [button setImage:[UIImage imageNamed:[[imageArray objectAtIndex:i] fileNameAppend:@"-未点击"]] forState:UIControlStateNormal];
                
                button.titleLabel.font = FONT15;
            }
            
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            
            button.tag = i;
            
            if (i == 0)
            {
                _currentButton = button;
                
                [button setTitleColor:_selectColor forState:UIControlStateNormal];
                
//                button.backgroundColor = [UIColor whiteColor];
                
                if ([imageArray count] > i)
                {
                    [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
                }
            }
            
            offX += _buttonWidth;
            
            [_buttonArray addObject:button];
        }
        
    }
    return self;
}

#pragma mark --
#pragma mark --添加头部的按钮选中   当前那个按钮被选中

- (void)btnClick:(UIButton *)button
{
    if (button == _currentButton)
    {
        return;
    }
    
    NSUInteger offX = button.tag;
    
    [button setTitleColor:_selectColor forState:UIControlStateNormal];
    
    
//    button.backgroundColor = [UIColor whiteColor];
    
    [_currentButton setTitleColor:_unSelectColor forState:UIControlStateNormal];
    
//    _currentButton.backgroundColor = [UIColor clearColor];
    
    
    if ([_imageArray count] > offX)
    {
        [button setImage:[UIImage imageNamed:[_imageArray objectAtIndex:offX]] forState:UIControlStateNormal];
        
        [_currentButton setImage:[UIImage imageNamed:[[_imageArray objectAtIndex:_currentButton.tag] fileNameAppend:@"-未点击"]] forState:UIControlStateNormal];
    }
    
    _currentButton = button;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _lineImageView.frame = CGRectMake(offX * _buttonWidth, 41, _buttonWidth, 3);
        
        _bgImageView.frame = CGRectMake(offX * _buttonWidth, 0, _buttonWidth, 41);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    if ([self.delegate respondsToSelector:@selector(headerButtonClick:)])
    {
        [self.delegate headerButtonClick:offX];
    }
}


- (void)currentSelectButton:(NSUInteger)index
{
    [self btnClick:[_buttonArray objectAtIndex:index]];
}


@end
