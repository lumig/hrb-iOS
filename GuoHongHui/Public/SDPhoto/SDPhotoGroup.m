//
//  SDPhotoGroup.m
//  SDPhotoBrowser
//
//  Created by aier on 15-2-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDPhotoGroup.h"
#import "SDPhotoItem.h"
#import "UIButton+WebCache.h"
#import "SDPhotoBrowser.h"

#define SDPhotoGroupImageGap  ([UIScreen mainScreen].bounds.size.width == 320 ? 10 : 15)

#define SDPhotoGroupImageMargin 5

#define kWidth [UIScreen mainScreen].bounds.size.width

#define kHeight      ([UIScreen mainScreen].bounds.size.width - 10 - 2* SDPhotoGroupImageGap - 60) / 3.0f


@interface SDPhotoGroup () <SDPhotoBrowserDelegate>
//height距离cell顶部的高度
@property(nonatomic,assign)CGFloat photoGroupHeight;

@end

@implementation SDPhotoGroup 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除图片缓存，便于测试
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        
    }
    return self;
}


- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    [photoItemArray enumerateObjectsUsingBlock:^(SDPhotoItem *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] init];
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal];
        
        
        btn.tag = idx;
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
    
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([_delegate respondsToSelector:@selector(getThePhotoGroupHeight)]) {
        
       _photoGroupHeight =  [_delegate getThePhotoGroupHeight];
    }
    
//    NSLog(@"magi height is %f",_photoGroupHeight);
    
    long imageCount = self.photoItemArray.count;
    int perRowImageCount = ((imageCount == 4) ? 2 : 3);
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    
    //图片的宽高
    CGFloat w = kHeight;
    CGFloat h = kHeight;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        
        long rowIndex = idx / perRowImageCount;
        int columnIndex = idx % perRowImageCount;
        CGFloat x = columnIndex * (w + SDPhotoGroupImageMargin);
        CGFloat y = rowIndex * (h + SDPhotoGroupImageMargin);
        btn.frame = CGRectMake(x, y, w, h);
    }];

    self.frame = CGRectMake(SDPhotoGroupImageGap + 60, _photoGroupHeight, kWidth, totalRowCount * (SDPhotoGroupImageMargin + h));
    
    
}

//- (void)getHeigthWithSDPhotoGroupBlock:(SDPhotoGroupBlock)sdBlcok
//{
//    if (sdBlcok) {
//        sdBlcok(YES,_sdPhotoHeight);
//    }
//    else
//    {
//        sdBlcok(NO,0);
//    }
//}

- (void)buttonClick:(UIButton *)button
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photoItemArray.count; // 图片总数
    browser.currentImageIndex = (int)button.tag;
    browser.delegate = self;
    [browser show];
    
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] currentImage];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [[self.photoItemArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}

@end
