//
//  GHStringManger.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "GHStringManger.h"

@implementation GHStringManger

+ (CGSize)stringBoundingRectWithSize:(CGSize)contentMaxSize font:(UIFont *)font text:(NSString *)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [text boundingRectWithSize:contentMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

@end
