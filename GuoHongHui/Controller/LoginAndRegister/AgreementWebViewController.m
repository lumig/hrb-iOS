//
//  AgreementWebViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/8.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "AgreementWebViewController.h"

@interface AgreementWebViewController ()

@end

@implementation AgreementWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"同意服务协议及隐私政策";
    
    NSString *urlStr = [NSString stringWithFormat:@"http://m.ghhbank.com/pc/?url=/31/20/p275274819492a5"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
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
