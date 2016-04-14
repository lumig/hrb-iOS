//
//  NewsWebViewController.m
//  GuoHongHui
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation NewsWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _webTitle;
    [self.view addSubview:self.webView];
    
    [self jumpToWeb];
    
}

#pragma mark --
#pragma mark -- event reponse
- (void)jumpToWeb
{
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSURLRequest *rquest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:rquest];
}

#pragma mark --
#pragma mark -- setter and getter
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+ 60)];
        _webView.delegate = self;
    }
    return _webView;
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
