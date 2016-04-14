//
//  payVC.m
//  hrb-iOS
//
//  Created by mac on 15/9/15.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "payVC.h"
#import "HomeViewController.h"
@interface payVC ()

@end

@implementation payVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backHomeClick:(id)sender {
//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    [self.navigationController pushViewController:homeVC animated:YES];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
