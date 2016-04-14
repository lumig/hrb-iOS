//
//  RegisterViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "AgreementWebViewController.h"
#import "AFNetworking.h"
#import "TTGlobalUICommon.h"
#import "NewsWebViewController.h"


@interface RegisterViewController ()<UIAlertViewDelegate>
{
    NSTimer *_codeTimer;
    int _iTime;
    BOOL _isAgree;
    BOOL _isSuccess;
}

@end

@implementation RegisterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =  @"手机注册";
    
    
    _isAgree = NO;
    
    self.phoneTextField.delegate = self;
    self.verifyTextField.delegate = self;
    self.pwdTextField.delegate = self;
    self.confirmPwdTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeButtonClick:)];
    
    [self.hintLabel addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapAgree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreementBtnClick)];
    self.agreementLabel.userInteractionEnabled = YES;
    [self.agreementLabel addGestureRecognizer:tapAgree];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.regsiterBtn.enabled = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
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

- (void)agreementBtnClick

{
    AgreementWebViewController *webVC = [[AgreementWebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
}



#pragma mark--
#pragma mark 验证码

- (IBAction)codeButtonClick:(id)sender 
    {
        self.codeButton.enabled = NO;
        if ([self.phoneTextField.text length] !=11) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            self.codeButton.enabled = YES;
            return;
        }
        
        
        [SMS_SDK getVerifyCodeByPhoneNumber:self.phoneTextField.text AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
            
            if (1==state)
            {
                
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


- (IBAction)phoneChange:(id)sender {
    
    [self isEmpty];
}

- (IBAction)pwdChange:(id)sender {
    [self isEmpty];
}

- (IBAction)confirmPwdChange:(id)sender {
    [self isEmpty];
}

- (IBAction)verifyChange:(id)sender {
    [self isEmpty];
}

- (IBAction)idCardChange:(id)sender {
    
    [self isEmpty];
}


 - (void)isEmpty
{
    if ([self.phoneTextField.text length] >0 && [self.verifyTextField.text length] >0 && [self.pwdTextField.text length]> 0 && [self.confirmPwdTextField.text length] >0 && [self.idCardText.text length]>0) {
        self.regsiterBtn.enabled = YES;
    }
}


- (IBAction)chooseBtnClick:(id)sender {
    
    _isAgree = !_isAgree;
    
    if (_isAgree) {
        [self.agreementBtn setImage:[UIImage imageNamed:@"选中_02.png" ]forState:UIControlStateNormal];
        
    }
    else
    {
        [self.agreementBtn setImage:[UIImage imageNamed:@"选中框_01.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)registerBtnClick:(id)sender 
{
    if (_isAgree)
    {
        TTAlertNoTitle(@"请先同意服务条款!谢谢!");
        return;
    }
    
    BOOL isIDCard = [self validateIDCardNumber:self.idCardText.text];
    if (isIDCard == NO) {
        TTAlertNoTitle(@"身份证输入有误，请重新输入!");
        return;
    }
    
    //验证验证码的合法性
    [SMS_SDK commitVerifyCode:self.verifyTextField.text result:^(enum SMS_ResponseState state)
     {
         if (1 == state)
         {
             [self doRegister];
         }
         else if(0==state)
         {
             TTAlertNoTitle(@"验证码输入错误!");
         }
     }];
    
    
}


- (void)doRegister
{
    
    
    NSDictionary *parameters = @{@"mobile":self.phoneTextField.text, @"password":self.pwdTextField.text,@"idCard":self.idCardText.text};
    [self showHudInView:self.view hint:@"正在注册..."];
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger POST:urlStr(@"user/register") parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self hideHud];
        
        NSDictionary *dict = [NSDictionary dictionary];
        dict = [responseObject mutableCopy];
        
//        NSLog(@"registor %@",dict);
        
     
        if (dict[@"userId"]) {
            _isSuccess = YES;
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"注册成功"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            alert.delegate = self;
        }
        else
        {
            TTAlert(@"网络不太好，请稍后再试！");
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self hideHud];
        
        TTAlert(@"您的网络不太好，请查看网络设置！");
        
    }];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_isSuccess) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
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
    
    self.hintLabel.text = codeString;
    self.hintLabel.textColor = [UIColor whiteColor];
    self.hintLabel.backgroundColor = [UIColor grayColor];
    if (_iTime == 0)
    {
        [_codeTimer invalidate];
        
        self.codeButton.enabled = YES;
        self.hintLabel.text = @"请重新获取";
    }
}


- (BOOL)validateIDCardNumber:(NSString *)value {
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    int length = 0;
    
    if (!value) {
        
        return NO;
        
    }else {
        
        length = (int)value.length;
        
        
        
        if (length !=15 && length !=18) {
            
            return NO;
            
        }
        
    }
    
    // 省份代码
    
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    
    
    NSString *valueStart2 = [value substringToIndex:2];
    
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]) {
            
            areaFlag =YES;
            
            break;
            
        }
        
    }
    
    
    
    if (!areaFlag) {
        
        return false;
        
    }
    
    
    
    
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    
    
    int year =0;
    
    switch (length) {
            
        case 15:{
            
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                              options:NSMatchingReportProgress
                             
                                                                range:NSMakeRange(0, value.length)];
            
            
            
            
            
            
            if(numberofMatch >0) {
                
                return YES;
                
            }else {
                
                return NO;
                
            }
        }
        case 18:
        {
            
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                              options:NSMatchingReportProgress
                             
                                                                range:NSMakeRange(0, value.length)];
            
            
            
            
            
            
            if(numberofMatch >0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                
                NSString *M =@"F";
                
                NSString *JYM =@"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    
                    return NO;
                    
                }
                
                
                
            }else {
                
                return NO;
                
            }
        }
        default:
            
            return false;
            
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
