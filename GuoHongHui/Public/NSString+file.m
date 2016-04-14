//
//  NSString+file.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "NSString+file.h"

@implementation NSString (file)


- (NSString *)fileNameAppend:(NSString*)append
{
    //取得没有后缀名的文件名
    NSString *fileName = [self stringByDeletingPathExtension];
    
    //拼接append
    fileName = [fileName stringByAppendingString:append];
    
    //拼接拓展名
    NSString *extension = [self pathExtension];
        
    return [fileName stringByAppendingPathExtension:extension];;
}


/**
 *  截屏
 *
 *  @param view 需要截屏的视图
 *
 *  @return 图片保存的地址
 */
+ (NSString *)screenshotView:(UIView *)view
{
    
    if (UIGraphicsBeginImageContextWithOptions != nil)
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    }
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Library/screenshot"];
    
    NSString *imagePath = [path stringByAppendingFormat:@"/%d.png",0];
    
    BOOL isDir= NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if ([UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES])
    {
        return imagePath;
    }
    
    
    return nil;
}


@end
