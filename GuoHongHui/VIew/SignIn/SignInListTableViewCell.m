//
//  SignInListTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "SignInListTableViewCell.h"

@implementation SignInListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellFillWithSignInModel:(SignInModel *)model
{
    if ([model.type intValue ] == -1) {
        [self setTextIsBlack:YES];
        self.huiAddLabel.text = @"惠金币增加";
        self.huiReduceLabel.text = @"惠金币消耗";
        self.sourceLabel.text = @"事由";
        self.createLabel.text = @"更新时间";
    }
    else
    {
        [self setTextIsBlack:NO];
        
        
        if ([model.codeAdd intValue] > 0)
        {
            self.huiAddLabel.text = [NSString stringWithFormat:@"%@",model.codeAdd];
//            self.huiReduceLabel.text = @"0";
            
        }
        else
        {
            self.huiAddLabel.text = @"0";
//            self.huiReduceLabel.text = [NSString stringWithFormat:@"%d",-[model.codeAdd intValue]];
        }
        
        self.sourceLabel.text = model.sourece;
        
//        NSString *created = [self dateFormatWithString:model.create];
        
        self.createLabel.text = model.create;
    }
}

- ( NSString *)dateFormatWithString:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"T" withString:@"\n"];
    
    NSRange range = [string rangeOfString:@"."];
    
    if ([string length] > range.location)
    {
        string = [string substringWithRange:NSMakeRange(0, range.location)];
    }
    
    return string;
}


- (void)setTextIsBlack:(BOOL)isBlack
{
    if (isBlack)
    {
        self.huiAddLabel.textColor = [UIColor blackColor];
        self.huiReduceLabel.textColor = [UIColor blackColor];
        self.sourceLabel.textColor = [UIColor blackColor];
        self.createLabel.textColor = [UIColor blackColor];
    }else
    {
        self.huiAddLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.huiReduceLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.sourceLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        self.createLabel.textColor = GH_COLOR(0.52, 0.52, 0.52);
        
        self.sourceLabel.font = FONT16;
        self.createLabel.font = FONT16;
    }
}


+ (CGFloat)cellHeight
{
    return 44;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
