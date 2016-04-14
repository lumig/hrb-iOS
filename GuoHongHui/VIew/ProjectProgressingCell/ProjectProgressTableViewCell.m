//
//  ProjectProgressTableViewCell.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectProgressTableViewCell.h"
#import "UIImageView+AFNetworking.h"

#define kImgHeight ([UIScreen mainScreen].bounds.size.width == 320 ? 100 : 120(
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kCellGap  ([UIScreen mainScreen].bounds.size.width == 320 ? 10 : 15)

#define SDPhotoGroupImageMargin 5

#define kHeight      (([UIScreen mainScreen].bounds.size.width - 10 - 2* (kCellGap)) / 3.0f)

@implementation ProjectProgressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.projectIcon];
        
        [self.contentView addSubview:self.projectName];
        
        [self.contentView addSubview:self.publicTime];
        
        [self.contentView addSubview:self.projectDesc];
        
        [self.contentView addSubview:self.photoGroup];
        
        [self.contentView addSubview:self.lineImgView];
        
    }
    return self;
}


- (UIImageView *)projectIcon
{
    if (_projectIcon == nil) {
    
        _projectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kCellGap, kCellGap, 50, 50)];
        
//        _projectIcon.layer.cornerRadius = 10;
//        _projectIcon.layer.masksToBounds = YES;
        
        _projectIcon.backgroundColor = [UIColor clearColor];
    }
    return _projectIcon;
}

- (UILabel *)projectName
{
    if (_projectName == nil) {
        
        _projectName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.projectIcon.frame) + 10, kCellGap, 250, 10)];
        _projectName.textAlignment = NSTextAlignmentLeft;
        [_projectName setFont:FONT15];
//        _projectName.textColor = GLOBAL_RedColor;
    }
    
    return _projectName;
}

- (UILabel *)publicTime
{
    if (_publicTime == nil) {
        
        _publicTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.projectIcon.frame) + 10, CGRectGetMaxY(self.projectName.frame) + 20, 150, 10)];
        [_publicTime setTextColor:[UIColor grayColor]];
        [_publicTime setFont:FONT14];
    }
    
    return _publicTime;
}

- (UILabel *)projectDesc
{
    if (_projectDesc == nil) {
        
        _projectDesc = [[UILabel alloc] initWithFrame:CGRectMake(kCellGap + 60, CGRectGetMaxY(self.projectIcon.frame) , kScreenWidth - 2 *kCellGap - 60, 0)];
        _projectDesc.font = FONT14;
        
        [_projectDesc setNumberOfLines:0];
    }
    return _projectDesc;
}

- (SDPhotoGroup *)photoGroup
{
    if (_photoGroup == nil) {
        
        _photoGroup = [[SDPhotoGroup alloc] initWithFrame:CGRectMake(kCellGap + 60, CGRectGetMaxY(self.projectDesc.frame) + 10, SCREEN_WIDTH - 2 *kCellGap - 60, SCREEN_WIDTH - 2 *kCellGap - 60)];
    }
    
    _photoGroup.delegate = self;
    return _photoGroup;
}

- (UIImageView *)lineImgView
{
    if (_lineImgView == nil) {
        _lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    }
    return _lineImgView;
}


+ (CGFloat)getTheDescHeightWithDescription:(NSString *)desc
{
   return [GHStringManger stringBoundingRectWithSize:CGSizeMake(kScreenWidth - 2 *kCellGap - 60, 1000) font:FONT14 text:desc].height;
}


- (void)fillCellWithProjectProgressInfo:(ProjectProgressInfo *)info
{
    [self.projectIcon setImageWithURL:[NSURL URLWithString:info.projectImgUrl] placeholderImage:GHSMALLIMAGE];
    
    [self.projectName setText:info.projectName];
    
    [self.publicTime setText:info.publicTime];
    
    if ([info.projectDesc length] > 0) {
        
        CGFloat descHeight = [ProjectProgressTableViewCell getTheDescHeightWithDescription:info.projectDesc];
        
        [self.projectDesc setFrame:CGRectMake(kCellGap + 60, CGRectGetMaxY(self.projectIcon.frame), kScreenWidth - 2 *(kCellGap) - 60, descHeight)];
        [self.projectDesc setText:info.projectDesc];
        
        _photoGroupHeight = (kCellGap) + 60 + descHeight;
    }
    else
    {
    _photoGroupHeight = (kCellGap) + 50;
    }
    
    if (info.imgArray.count > 0) {
        NSMutableArray *temp = [NSMutableArray array];
        [info.imgArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
            SDPhotoItem *item = [[SDPhotoItem alloc] init];
            item.thumbnail_pic = src;
            [temp addObject:item];
        }];
        
        self.photoGroup.photoItemArray = [temp copy];
        

    }
    
    [_lineImgView setFrame:CGRectMake(0, [ProjectProgressTableViewCell getCellHeightWithProjectProgressInfo:info]- 10,SCREEN_WIDTH, 10)];
    [_lineImgView setImage:[UIImage imageNamed:@"line.png"]];
  
    
}

- (CGFloat)getThePhotoGroupHeight
{
    return _photoGroupHeight;
}

+ (CGFloat)getPhotoGroupWithProjectProgressInfo:(ProjectProgressInfo *)info
{
    
    long imageCount = info.imgArray.count;
    int perRowImageCount = ((imageCount == 4) ? 2 : 3);
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    
    //图片的宽高
    CGFloat h = kHeight;
    
    CGFloat height = totalRowCount * (SDPhotoGroupImageMargin + h);

    
    return height;
}

+ (CGFloat)getCellHeightWithProjectProgressInfo:(ProjectProgressInfo *)info
{
    return [ProjectProgressTableViewCell getTheDescHeightWithDescription:info.projectDesc] + [ProjectProgressTableViewCell getPhotoGroupWithProjectProgressInfo:info] + 60 ;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
