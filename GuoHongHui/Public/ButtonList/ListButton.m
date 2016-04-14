//
//  ListButton.m
//  btnList
//
//  Created by apple on 15/6/1.
//  Copyright (c) 2015年 GUOHONGHUI. All rights reserved.
//

#import "ListButton.h"

//#define kHeight [UIScreen mainScreen].bounds.size.width / 4.0f
#define kHeight(frame) frame.size.width
#define kRatio 0.65

@implementation ListButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = FONT15;
        
        //        self.titleLabel.textColor = [UIColor blackColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.adjustsImageWhenHighlighted = NO;
        
    }
    return self;
}
//设置UILabel的边界
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = kHeight(contentRect) * kRatio;
    CGFloat titleWidth = self.frame.size.width;
    CGFloat titleHeight = 20;
    return CGRectMake(0, titleY, titleWidth, titleHeight);
}

//设置UIImageView的边界
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageWidth =contentRect.size.width / 3.0f;
    CGFloat imageHeight = kHeight(contentRect);
    return CGRectMake(contentRect.size.width/ 2.0f - imageWidth / 2.0f, imageHeight * kRatio / 3.0f, imageWidth , imageWidth);
}




@end
