//
//  LoginViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "LoginViewController.h"
#import "UserModel.h"
#import "ResetViewController.h"
#import "RegisterViewController.h"
#import "UserInfo.h"
#import "RegisterViewController.h"
#import "ResetViewController.h"
#import "HomeViewController.h"
#import "GHConfig.h"
#import "MyViewController.h"
#import "NavViewController.h"

@interface LoginViewController ()

@property(nonatomic,strong)UserMessageDataBase *db;
@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic,strong)NSMutableArray *userDataArr;
@property(nonatomic,strong)NSDictionary *dict;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;
    
    self.pswTestField.delegate = self;
    
    //初始化数据库
    [self initDB];
   
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
    }
    
    return self;
}

#pragma mark -- 
#pragma mark -- delegate district

#pragma amrk --
#pragma mark -- TextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.nameTextField]) {
        
        UserInfo *info = [_db findUserMessageWithUsername:textField.text ];
        
        
        if (info) {
            
            self.pswTestField.text = info.password;
            
            if (info.password) {
                self.loginBtn.enabled = YES;
            }
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        [textField resignFirstResponder];
        [self.pswTestField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        [self loginClick:nil];
    }
    return YES;
}


#pragma mark --
#pragma mark -- event response

- (void)initDB
{
    _db = [[UserMessageDataBase alloc] init];
    [_db createUserMessageDataBase];
}

- (IBAction)nameChanged:(id)sender
{
    [self isEmpty];
}

- (IBAction)pswChanged:(id)sender
{
    [self isEmpty];
}

- (void)isEmpty
{
    if ([self.nameTextField.text length] > 0 && [self.pswTestField.text length] > 0) {
        self.loginBtn.enabled = YES;
    }
}

- (IBAction)loginClick:(id)sender
{
    if ([self.nameTextField.text length] == 0) {
        TTAlert(@"请输入手机号");
        return;
    }
    
    if ([self.pswTestField.text length] == 0) {
        TTAlert(@"请输入密码");
        return;
    }
    
    [self showHudInView:self.view hint:@"正在登录..."];
    
    [self loginWithUserName:self.nameTextField.text andPassword:self.pswTestField.text];
    
}


- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    
    __block NSString *message = @"";
    
    [self.userModel getUserDataWithPhone:userName andPassword:password andUserBlock:^(BOOL state, NSDictionary *dataDict) {
        
//        NSLog(@"dataDict%@",dataDict);
        [self hideHud];
        
        [self saveDataBaseWithUserName:userName andPassword:password];
        
        //保存用户名
//        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"username"];
        
        if (state) {
            _dict = [dataDict mutableCopy];
            
            NSString *idCard = [_dict objectForKey:@"iDcard"];
            NSString *userId = [_dict objectForKey:@"userId"];
            NSString *huiCode = [_dict objectForKey:@"huijinCoupon"];
//            NSString *icon = [_dict objectForKey:@"iconUrl"];
//            if (![icon isEqual:nil]) {
//                [[NSUserDefaults standardUserDefaults] setObject:icon forKey:@"icon"];
//            }
            if (idCard !=nil) {
                
                NSLog(@"登录成功！");
                
                [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
                
                [[NSUserDefaults standardUserDefaults] setObject:huiCode forKey:@"huiCode"];
                [[NSUserDefaults standardUserDefaults ] setObject:idCard forKey:@"idCard"];
                [self loginToHomeVC];
                if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                    [self.delegate loginSuccess];
                }
            }
            else
            {
                message = @"登录失败！";
                
                [self alertWithString:message];
            }
        }
        
        
        
    }];
    
}

- (void)loginToHomeVC
{
    switch (_type) {
        case 0:
        {
            HomeViewController *homeVC = [[HomeViewController alloc] init];
            
            [self.navigationController pushViewController:homeVC animated:YES];}
            break;
            
       case 1:
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            
        default:
       
            break;
    }
    
    
    
}

- (void)alertWithString:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)saveDataBaseWithUserName:(NSString *)username andPassword:(NSString *)password
{
    UserInfo *info = [[UserInfo alloc] initWithUsername:username andPassword:password];
    
    [_db addUserMessage:info];
    
    //保存到NSUserDefaults
    [self addUserDefaultsWithUserName:username];
    
}

#pragma mark --
#pragma mark --  保存到NSUserDefaults
- (void)addUserDefaultsWithUserName:(NSString *)username
{
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"globalUserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (IBAction)reSetBtnClick:(id)sender
{
    ResetViewController *resetVC = [[ResetViewController alloc] init];
    [self.navigationController pushViewController:resetVC animated:YES];
}

- (IBAction)registerBtnClick:(id)sender
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark --
#pragma mark -- setter and getter

- (UserModel *)userModel
{
    if (_userModel == nil) {
        _userModel = [[UserModel alloc] init];
    }
    
    return _userModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






@end
