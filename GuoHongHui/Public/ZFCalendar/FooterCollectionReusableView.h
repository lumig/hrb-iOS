//
//  FooterCollectionReusableView.h
//  Calendar
//
//  Created by LuMig on 15/5/20.
//  Copyright (c) 2015年 张凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic)  UIImageView *waitingImgView;

@property (strong, nonatomic)  UILabel *waitingNameLabel;


@property (strong, nonatomic)  UILabel *waitingMoneyLabel;

@property (strong, nonatomic)  UIImageView *havingImgView;

@property (strong, nonatomic)  UILabel *havingNameLabel;

@property (strong, nonatomic)  UILabel *havingMoneyLabel;

@end
