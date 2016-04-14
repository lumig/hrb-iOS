//
//  GHConfig.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/18.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "GHConfig.h"

@implementation GHConfig

- (void)setUserName:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"globalUserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userName
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"globalUserName"]) {
        
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"globalUserName"];
    }
    
    return nil;
}

@end
