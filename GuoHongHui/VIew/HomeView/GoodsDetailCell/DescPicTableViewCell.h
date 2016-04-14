//
//  DescPicTableViewCell.h
//  GuoHongHui
//
//  Created by mac on 15/7/31.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+AFNetworking.h>
@interface DescPicTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *descLabel;

- (void)cellFillDescPictDict:(NSDictionary *)dict;
+ (CGFloat)cellHeight;
@end
