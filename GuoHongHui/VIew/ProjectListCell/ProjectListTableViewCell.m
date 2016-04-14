//
//  ProjectListTableViewCell.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/12.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectListTableViewCell.h"
#import "UIImageView+AFNetworking.h"

#define  kCellHight   [UIScreen mainScreen].bounds.size.width == 320 ? 80:100
#define  kImgHightGap [UIScreen mainScreen].bounds.size.width == 320 ? 10:20
#define  kCellGap    [UIScreen mainScreen].bounds.size.width == 320 ? 10 :15
#define  kWidth    [UIScreen mainScreen].bounds.size.width

@implementation ProjectListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.imgView];
        
        [self.contentView addSubview:self.nameLable];
        
//        [self.contentView addSubview:self.tagImgView];
        
        [self.contentView addSubview:self.descLabel];
        
//        [self.contentView addSubview:self.createTimeLabel];
        
        [self.contentView addSubview:self.lineImgView];
    }
    return self;
}

- (UILabel *)nameLable
{
    if (_nameLable == nil) {
        
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 15, kImgHightGap, 150, 10)];
        [_nameLable setFont:FONT15];
        
    }
    return _nameLable;
}

- (UILabel *)descLabel
{
    if (_descLabel == nil) {
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 10, CGRectGetMaxY(self.nameLable.frame),( (kWidth) -(kCellGap) )- CGRectGetMaxX(self.imgView.frame) , (kCellHight) - 2*(kCellGap)- 15  )];
        [_descLabel setNumberOfLines:5];
        
        [_descLabel setFont:FONT16];
    }
    return _descLabel;
    
}

- (UILabel *)createTimeLabel
{
    if (_createTimeLabel == nil) {
        
        _createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth - 150, (kCellHight) - (kCellGap),150, kCellGap)];
        
        [_createTimeLabel setFont:FONT15];
        
        _createTimeLabel.textAlignment = NSTextAlignmentRight;
        [_createTimeLabel setTextColor:[UIColor grayColor]];
    }
    
    return _createTimeLabel;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kCellGap, kImgHightGap, 60, 60)];
        _imgView.backgroundColor = [UIColor clearColor];
        
        _imgView.layer.cornerRadius = 10;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UIImageView *)tagImgView
{
    if (_tagImgView == nil) {
        _tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 60, 0, 60, 20)];
        _tagImgView.image = [UIImage imageNamed:@"biaoqian.png"];
    }
    return _tagImgView;
}

- (UIImageView *)lineImgView
{
    if (_lineImgView == nil) {
        
        _lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ProjectListTableViewCell hightForCell] - 1, SCREEN_WIDTH, 1)];
            [self.lineImgView setImage:[UIImage imageNamed:@"line_01.png"]];

        
    }
    return _lineImgView;
}
+ (CGFloat)hightForCell
{
    return kCellHight;
}

- (void)fillCellWithProjectListInfo:(ProjectListInfo *)info
{
    [self.imgView setImageWithURL:[NSURL URLWithString:info.projectImgUrl] placeholderImage:GHSMALLIMAGE];
    
    [self.nameLable setText:info.projectName];
    
    [self.descLabel setText:info.projectDesc];
    
    [self.createTimeLabel setText:info.createTime];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
