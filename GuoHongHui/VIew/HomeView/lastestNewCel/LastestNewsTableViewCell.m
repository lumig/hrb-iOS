//
//  LastestNewsTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/17.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "LastestNewsTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#define kNewsDescWidth ([UIScreen mainScreen].bounds.size.width == 320 ?SCREEN_WIDTH - 2*kGap - 80:SCREEN_WIDTH - 2*kGap - 70-5)
@implementation LastestNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
   
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        [_imgView setFrame:CGRectMake(kGap, 5, 70, 70)];
        [self.contentView addSubview:_imgView];
        
        _newsNameLabel = [[UILabel alloc] init];
        [_newsNameLabel setFrame:CGRectMake(kGap + 80, 5, kNewsDescWidth, 20)];
        _newsNameLabel.font = FONT16;
        
        _newsDescLabel = [[UILabel alloc] init];
        [_newsDescLabel setFrame:CGRectMake(kGap + 80 , CGRectGetMaxY(_newsNameLabel.frame)+5, kNewsDescWidth, 75 - CGRectGetMaxY(_newsNameLabel.frame)  - 10)];
        _newsDescLabel.numberOfLines = 3;
        _newsDescLabel.font = FONT14;
        
        _lineImgView = [[UIImageView alloc] init];
        [_lineImgView setFrame:CGRectMake(0, 84, SCREEN_WIDTH, 1)];
        [_lineImgView setBackgroundColor:GLOBAL_GrayColor];
        
        [self.contentView addSubview:_lineImgView];
        [self.contentView addSubview:_newsNameLabel];
        [self.contentView addSubview:_newsDescLabel];
    }
    return self;
}

- (void)cellFillWithLastestNewsModel:(LastestNewsModel *)model
{
    [_imgView setImageWithURL:[NSURL URLWithString:model.imgView] placeholderImage:GHSMALLIMAGE];
    
    
    _newsNameLabel.text = model.newsName;
    
    _newsDescLabel.text = model.newsDesc;
    
}

+ (CGFloat)cellHeight
{
    return 80 + 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
