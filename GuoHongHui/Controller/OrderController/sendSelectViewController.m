//
//  sendSelectViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "sendSelectViewController.h"
#import "UserInfo.h"
@interface sendSelectViewController ()
@end

@implementation sendSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"配送方式";
    
    
    _index = 100;
    
    _addressArray = @[@"系统匹配快递"];
    
    _sendTimeArray = @[@"只工作日送货（双休日，假日不用送）",@"双休日，假日送货（工作日不用送）",@"工作日、双休日与假日均可送货"];
    
    [self.selectBtn1 setImage:[UIImage imageNamed:@"i_checkbx_on.png"] forState:UIControlStateSelected];
    [self.selectBtn1 setImage:[UIImage imageNamed:@"i_checkbx_off.png"] forState:UIControlStateNormal];
    self.selectBtn1.tag = 100;
    [self.selectBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.selectBtn1.tag == _index) {
        self.selectBtn1.selected = YES;
    }
    else
    {
        self.selectBtn1.selected = NO;
    }
    
    
    [self.selectBtn2 setImage:[UIImage imageNamed:@"i_checkbx_on.png"] forState:UIControlStateSelected];
    [self.selectBtn2 setImage:[UIImage imageNamed:@"i_checkbx_off.png"] forState:UIControlStateNormal];
    self.selectBtn2.tag = 101;
    [self.selectBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.selectBtn2.tag == _index) {
        self.selectBtn2.selected = YES;
    }
    else
    {
        self.selectBtn2.selected = NO;
    }
    
    [self.selectBtn3 setImage:[UIImage imageNamed:@"i_checkbx_on.png"] forState:UIControlStateSelected];
    [self.selectBtn3 setImage:[UIImage imageNamed:@"i_checkbx_off.png"] forState:UIControlStateNormal];
    self.selectBtn3.tag = 102;
    [self.selectBtn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (self.selectBtn3.tag == _index) {
        self.selectBtn3.selected = YES;
    }
    else
    {
        self.selectBtn3.selected = NO;
    }
    
    
    self.confirmBtn.layer.cornerRadius =6;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateSelected];
    self.confirmBtn.backgroundColor = GLOBAL_RedColor;
    [self addLeftBtn];
    
}

- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == _index) {
        
        return;
    }
    
    else
    {
        UIButton *button = (UIButton *)[self.view viewWithTag:_index];
        button.selected = NO;
        
        btn.selected = YES;
        _index = btn.tag;
    }
}

- (IBAction)confirmBtnClick:(id)sender {
    
    [[UserInfo shareUserInfo] saveExpressName:[_addressArray objectAtIndex:0]];
    
    [[UserInfo shareUserInfo] saveSendGoodsTime:[_sendTimeArray objectAtIndex:_index - 100]];
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)addLeftBtn
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22.5, 24)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"i_arrow_white_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
}

#pragma mark -- buttonClick

- (void)backClicked:(id)sender
{
    //    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
