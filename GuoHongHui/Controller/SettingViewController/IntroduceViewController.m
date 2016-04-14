//
//  IntroduceViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "IntroduceViewController.h"

#define urlString     [NSString stringWithFormat:@"http://m.ghhbank.com/pc/?url=/12/58/p2698302424154d&"]


@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公司介绍";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *rquest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:rquest];
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

@end
