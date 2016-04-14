//
//  ResetViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ResetViewController.h"
#import "SMS_SDK/SMS_SDK.h"
#import "SMS_SDK/CountryAndAreaCode.h"
#import "AFNetworking.h"

#define urlString     [NSString stringWithFormat:@"http:app.dajunbank.com/index.php/Index"]

@interface ResetViewController ()<UITextFieldDelegate>
{
    NSTimer *_codeTimer;
    int _iTime;
    BOOL _isModify;
}

@end

@implementation ResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"重置密码";
    
    self.phoneTextField.delegate = self;
    
    self.codeTestField.delegate = self;
    self.nowPwdTestField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeBtnClick:)];
    [self.codeLabel addGestureRecognizer:tap];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.finishBtn.enabled = NO;
}

#pragma mark --
#pragma mark -- delegate district

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark --
#pragma mark -- event response

- (IBAction)phoneChange:(id)sender {
    
    [self isEmpty];
}

- (IBAction)codeChange:(id)sender {
    
    [self isEmpty];
}

- (IBAction)nowPwdChange:(id)sender {
    
    [self isEmpty];
}

- (void)isEmpty
{
    if ([self.phoneTextField.text length] > 0 && [self.codeTestField.text length] > 0 && [self.nowPwdTestField.text length] > 0) {
     
        self.finishBtn.enabled = YES;
    }
    
//    if ([self.nowPwdTestField.text length] < 6) {
//        TTAlert(@"请输入6-12位的密码");
//    }
    
    
}

- (IBAction)codeBtnClick:(id)sender {
    
    if ([self.phoneTextField.text length] == 0) {
        
        TTAlert(@"请输入手机号码！");
        return;
    }
    
    if ([self.phoneTextField.text length] != 11) {
        
        TTAlert(@"手机号码输入有误，请重新输入！");
        return;
    }
    
    [SMS_SDK getVerifyCodeByPhoneNumber:self.phoneTextField.text AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
        
        if (1==state)
        {
            self.codeBtn.enabled = NO;
            TTAlertNoTitle(@"获取验证码成功!");
            
            [self startTimer];
        }
        else if(0 == state)
        {
            TTAlertNoTitle(@"获取验证码失败!");
        }
        else if(SMS_ResponseStateMaxVerifyCode == state)
        {
            TTAlertNoTitle(@"超过最大短信数!");
        }else  if(SMS_ResponseStateGetVerifyCodeTooOften==state)
        {
            TTAlertNoTitle(@"操作太频繁!");
        }
    }];
    
}

- (IBAction)FinishBtnClick:(id)sender {
    
    [self showHudInView:self.view hint:@"正在重置密码..."];
    
    [self replacePwdWithPhone:self.phoneTextField.text andPassword:self.nowPwdTestField.text ];
    
}

#pragma mark --
#pragma mark -- 开启定时器

- (void)startTimer
{
    _codeTimer = nil;
    [_codeTimer invalidate];
    
    _iTime = 60;
    
    _codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(codeTimer) userInfo:nil repeats:YES];
}

- (void)codeTimer
{
    NSString *codeString = [NSString stringWithFormat:@"%d秒后重新获取",_iTime--];
    
    self.codeLabel.text = codeString;
    
    
    if (_iTime == 0)
    {
        [_codeTimer invalidate];
        
        self.codeBtn.enabled = YES;
        self.codeLabel.text = @"请重新获取";
    }
}


- (void)replacePwdWithPhone:(NSString *)phone andPassword:(NSString *)password

{
    NSDictionary *parameters = @{@"mobile":phone,@"password":password};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
   
    [manager POST:urlStr(@"user/resetPassword") parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hideHud];
        
        _isModify = YES;
        NSDictionary *dict = (NSDictionary *)responseObject;
        if (dict != nil) {
            NSLog(@"重置成功");
            
            
            [self alertView:@"重置成功！"];
        }
        else
        {
            TTAlert(@"网络不太好，请稍后再试！");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideHud];
        NSLog(@"error %@",[error localizedDescription]);
        TTAlert(@"您的网络不太好，请查看设置！");
    }];
}

- (void)alertView:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_isModify) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
