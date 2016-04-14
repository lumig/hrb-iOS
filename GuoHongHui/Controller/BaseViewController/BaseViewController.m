//
//  BaseViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
@interface BaseViewController ()<LoginDelegate>

@end

@implementation BaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
    
}
 
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBACOLOR(248, 248, 248, 1);
   
    [self addLeftNavBtn];
}



#pragma mark --
#pragma mark -- event response
//适配
-(float)selectedUIWidth:(float)width{
    if ([DEVICE isEqualToString:@"iphone6"]) {
        return width;
        ;
    }else if ([DEVICE isEqualToString:@"iphone6 plus"]){
        return width*414/375.0;
    }else{
        return width*320/375.0;
    }
}

-(float)selectedUIHeight:(float)height{
    if ([DEVICEHHEIGHT isEqualToString:@"iphone6"]) {
        return height;
        
    }else if ([DEVICEHHEIGHT isEqualToString:@"iphone6 plus"]){
        return height*736/667.0;
    }else if ([DEVICEHHEIGHT isEqualToString:@"iphone5"]){
        return height*568/667.0;
    }else{
        return height*480/667.0;
        
    }
    
}


#pragma mark --
#pragma mark -- 网络错误 关闭/显示 的视图


- (void)showNetWorkErrorView:(NSString *)errorMessage
{
    [self.view addSubview:self.networkView];
    
    if ([errorMessage length] > 0) {
        self.errorLabel.text = errorMessage;
    }
}

- (void)removeNetWorkErrorView
{
    [self.networkView removeFromSuperview];
}

#pragma mark --
#pragma mark -- 重新加载视图数据

- (void)loadNetWorkData
{
    
}

- (void)isLogin
{
    if ([[NSUserDefaults standardUserDefaults
          ] objectForKey:@"idCard"] == nil) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.type = 1;
        NavViewController *nav= [[NavViewController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (void)isHavingMessageToShow
{
    [self.view addSubview:self.imgView];
    
}

//对所有的界面来说，都会调用这个方法
//- (BOOL)checkLoginWithDelegate:(id)delegate {
//    BOOL isLogin = NO;
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"]) {
//        isLogin = YES;
//    }
//    if (isLogin == NO)
//    {
//        LoginViewController *loginVC = [[LoginViewController alloc] initWithDelegate:self];
//        loginVC.delegate = delegate;
//    }
//    return isLogin;
//}

//要用uitableview书写·
- (void)addLeftNavBtn
{
    if (self.navigationController && self.navigationController.viewControllers.count > 1)
    {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22.5, 24)];
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn setImage:[UIImage imageNamed:@"i_arrow_white_left.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backButtonItem;
    }
}

//自定义NAV返回按钮
- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --
#pragma mark -- setter and getter


- (void)setNetWorkFrame:(CGRect)netWorkFrame
{
    CGRect rect = self.networkView.frame;
    
    rect.origin.y -= netWorkFrame.origin.y;
    
    self.networkView.frame = rect;
}

- (UIView *)networkView
{
    if (_networkView == nil)
    {
        _networkView = [[UIView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 240) * 0.5, self.view.frame.size.width, 240)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_networkView.frame.size.width - 100) * 0.5, 0, 100, 81)];
        
        imageView.image = [UIImage imageNamed:@"failed_network.png"];
        
        [_networkView addSubview:imageView];
        
        self.errorLabel.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, _networkView.frame.size.width, 20);
        
        self.errorLabel.text = @"数据加载失败了";
        
        [_networkView addSubview:self.errorLabel];
        
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.errorLabel.frame) + 10, _networkView.frame.size.width, 20)];
        
        descLabel.textAlignment = NSTextAlignmentCenter;
        
        descLabel.text = @"请检查您的网络,重新加载吧";
        
        descLabel.textColor = [UIColor grayColor];
        
        [_networkView addSubview:descLabel];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake((_networkView.frame.size.width - 120) * 0.5, CGRectGetMaxY(descLabel.frame) + 20, 120, 40);
        
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        
        [btn setTitleColor:NAV_Color forState:UIControlStateNormal];
        
        btn.titleLabel.font = FONT17;
        
        [btn addTarget:self action:@selector(loadNetWorkData) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 6;
        
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = NAV_Color.CGColor;
        
        
        [_networkView addSubview:btn];
    }
    
    return _networkView;
}

- (UILabel *)errorLabel
{
    if (_errorLabel == nil)
    {
        _errorLabel = [[UILabel alloc]init];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _errorLabel;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 160)];
        _imgView.center = CGPointMake(SCREEN_WIDTH /2.0, SCREEN_HEIGHT/2.0);
        _imgView.image = [UIImage imageNamed:@"noMess.png"];
    }
    
    return _imgView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
