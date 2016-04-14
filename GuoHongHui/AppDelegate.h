//
//  AppDelegate.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString *goodsNumber;

@property(nonatomic,strong)MainViewController *mainVC;


//@property float autoSizeScaleX;
//@property float autoSizeScaleY;
@end

