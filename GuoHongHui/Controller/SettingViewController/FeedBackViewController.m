//
//  FeedBackViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "FeedBackViewController.h"

#import "AFNetworking.h"

#define urlString [NSString stringWithFormat:@"http://app.dajunbank.com/index.php/Index/FeedBack"]
@interface FeedBackViewController ()<UITextViewDelegate,UIAlertViewDelegate>

{
    BOOL _isFeedBack;
}
@end

@implementation FeedBackViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isLogin];
    
    self.title = @"意见反馈";
    
    self.TextView.delegate = self;
    
    self.TextView.returnKeyType= UIReturnKeyDone;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.submitBtn.enabled = NO;
}


#pragma mark --
#pragma mark -- Delegate District

#pragma mark --
#pragma mark -- textView Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 0) {
        self.placeholderLabel.text = @"";
        
        self.submitBtn.enabled = YES;
    }
    else
    {
        self.placeholderLabel.text =@"请留下您的宝贵意见和建议!";
        
    }
}

#pragma mark --
#pragma mark --alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_isFeedBack) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    else
    {
        return YES;
    }
}

#pragma mark -- 
#pragma mark -- UIResponder delegate 收起键盘

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self.TextView resignFirstResponder];
}

#pragma mark --
#pragma mark -- Event Response

- (IBAction)SubmitClick:(id)sender {
    
    [self showHudInView:self.view hint:@"正在上传..."];
    
    [self submitFeedBackWithMemberID:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] andOpinion:self.TextView.text];
    //    NSLog(@"magi%@",self.TextView.text);
    
}

- (void)submitFeedBackWithMemberID:(NSString *)memberid andOpinion:(NSString *)opinion
{
    
    NSDictionary *parameters = @{@"memberid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"], @"title":opinion};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    __block NSString *message;
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self hideHud];
        NSLog(@"%@",responseObject);
        
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
        if (responseObject != nil)  {
//            NSDictionary *dic = (NSDictionary *)responseObject;
//            
//            NSString *num = @"";
//            
//            num = [dic objectForKey:@"count"];
//            
//            if ([num isEqualToString:@"1"]) {
            
                _isFeedBack = YES;
                
                message = @"您的意见我们已收到！";
                
                NSLog(@"上传成功！");
//            }
          
        }
        else
        {
            message = @"网络异常，请稍 后再试！";
        }
        
        [self showAlertMessage:message];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self hideHud];
        NSLog(@"error:%@",[error localizedDescription]);
        
        message = @"网络异常，请查看你的网络设置！";
        //        TTAlert(@"服务器繁忙!请稍后再试谢谢!");
        
        [self showAlertMessage:message];
        
    }];
}

- (void)showAlertMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark --
#pragma mark -- setter and getter






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
