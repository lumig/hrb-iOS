//
//  GHStringManger.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHStringManger : NSObject

+ (CGSize)stringBoundingRectWithSize:(CGSize)contentMaxSize font:(UIFont *)font text:(NSString *)text;
@end
