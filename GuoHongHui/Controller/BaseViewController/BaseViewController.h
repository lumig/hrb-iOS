//
//  BaseViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
@interface BaseViewController : UIViewController

@property(strong,nonatomic)UIView  *networkView;

@property (strong,nonatomic)UILabel *errorLabel;

@property(strong,nonatomic)UIImageView *imgView;

-(float)selectedUIWidth:(float)width;
-(float)selectedUIHeight:(float)height;

//判断是否登录
//- (BOOL)checkLoginWithDelegate:(id)delegate;

#pragma mark --
#pragma mark -- 显示网络错误

- (void)showNetWorkErrorView:(NSString *)errorMessage;

#pragma mark --
#pragma mark -- 关闭网络错误
- (void)removeNetWorkErrorView;



#pragma mark --
#pragma mark -- 网络从新加载

- (void)loadNetWorkData;

- (void)isLogin;

- (void)isHavingMessageToShow;
@end
