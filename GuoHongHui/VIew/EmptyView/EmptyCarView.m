//
//  EmptyCarView.m
//  iosApp
//
//  Created by admin on 15/2/10.
//  Copyright (c) 2015年 lifevc. All rights reserved.
//

#import "EmptyCarView.h"

@implementation EmptyCarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 130)/2.0f,(self.frame.size.height - 300)/2.0f, 130, 140)];
        [self.imgView setImage:[UIImage imageNamed:@"noMess"]];
        
        [self addSubview:_imgView];
    }
    return self;
}



//
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    self.strollButton.layer.masksToBounds = YES;
//    self.strollButton.layer.cornerRadius = 6;
//    self.strollButton.layer.borderWidth = 1;
//    self.strollButton.layer.borderColor = COLOR_NAV_SELECTED.CGColor;
//}

//- (IBAction)strollButtonClick:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(emptyViewDidClick)]) {
//        [self.delegate emptyViewDidClick];
//    }
//}
@end
