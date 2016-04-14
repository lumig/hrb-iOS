//
//  ModifyPswViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ModifyPswViewController.h"
#import "AFNetworking.h"
#import "LoginViewController.h"

#define urlString     [NSString stringWithFormat:@"http://app.dajunbank.com/index.php/Index/Uppwd"]


@interface ModifyPswViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,assign)BOOL isModify;
@end

@implementation ModifyPswViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isLogin];
    
    self.title = @"修改密码";
    
    self.oldTextField.delegate = self;
    self.nowTextField.delegate = self;
    self.confirmTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.submitBtn.enabled = NO;
}


#pragma mark --
#pragma mark -- Deletate District

#pragma mark --
#pragma mark -- alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (_isModify) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
    LoginViewController *loginVC= [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

#pragma mark --
#pragma mark -- UIResponder delegate

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma amrk --
#pragma mark -- textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark --
#pragma mark -- Event Response

- (IBAction)submitClick:(id)sender {
    
    if ([self.oldTextField.text length] == 0) {
        TTAlert(@"请输入密码!");
        return;
    }
    
    if ([self.nowTextField.text length] == 0) {
        TTAlert(@"请输入新密码!");
        return;
    }
    if ([self.confirmTextField.text length] == 0) {
        TTAlert(@"请输入确认密码！");
        return;
    }
    
    
    if (![self.nowTextField.text isEqualToString:self.confirmTextField.text]) {
        
        //        [self alertView:@"新密码输入不一致!"];
        
        TTAlert(@"新密码输入不一致!");
        
        return;
        
    }
    
    [self showHudInView:self.view hint:@"正在修改..."];
    
    [self submitMessageWithMemberID:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] andOldPwd:self.oldTextField.text andNewPwd:self.nowTextField.text];
    
    
}

- (void)alertView:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (void)submitMessageWithMemberID:(NSNumber *)memberID andOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd
{
//    NSLog(@"magi %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]);
    NSDictionary *parameters = @{@"mobile":[NSString stringWithFormat:@"%@",memberID],@"oldPassword":oldPwd,  @"newPassword":newPwd};
    
    __block NSString *message;
    NSString *urlStr = urlStr(@"user/changePassword");
    [[AFHTTPRequestOperationManager manager] POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//                NSLog(@"magi%@",responseObject);
        
        _isModify = YES;
        
        [self hideHud];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic = (NSDictionary *)responseObject;
//            
            
            
            if (dic != nil) {
                
                //                TTAlert(@"修改成功！");
                message = @"修改成功！";
            }
            else
            {
                message = @"输入的原始密码不正确！";
            }
            
            [self alertView:message];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self hideHud];
        NSLog(@"errror%@",error);
        
        TTAlert(@"服务器繁忙!请稍后再试谢谢!");
        
    }];
}


- (IBAction)oldChang:(id)sender {
    
    [self isEmpty];
}

- (IBAction)newChange:(id)sender {
    [self isEmpty];
}

- (IBAction)confirmChange:(id)sender {
    
    [self isEmpty];
}

- (void)isEmpty
{
    if ([self.oldTextField.text length] > 0 && [self.nowTextField.text length] > 0 && [self.confirmTextField.text length] > 0) {
        
        self.submitBtn.enabled = YES;
    }
}


#pragma mark --
#pragma mark -- setter and getter



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
