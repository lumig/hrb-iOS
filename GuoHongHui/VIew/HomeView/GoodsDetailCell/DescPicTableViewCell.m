//
//  DescPicTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/31.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "DescPicTableViewCell.h"
#define imgHeight ([UIScreen mainScreen].bounds.size.width == 320 ? 160:180)

@implementation DescPicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, imgHeight)];
        [self addSubview:_imgView];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(kGap, CGRectGetMaxY(_imgView.frame)+5, SCREEN_WIDTH - 2*kGap, 15)];
        _descLabel.font = FONT14;
        [self addSubview:_descLabel];
        
    }
    return self;
    
}

- (void)cellFillDescPictDict:(NSDictionary *)dict
{
    [_imgView setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"imageUrl"]] placeholderImage:GHSMALLIMAGE];
    
    [_descLabel setText:[dict objectForKey:@"imageDesc"]];
}

+(CGFloat)cellHeight
{
    return imgHeight + 25;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
