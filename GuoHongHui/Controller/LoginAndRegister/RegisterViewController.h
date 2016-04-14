//
//  RegisterViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;
//获取验证码的label
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@property (weak, nonatomic) IBOutlet UIButton *regsiterBtn;

@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;

@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;

@property (weak, nonatomic) IBOutlet UITextField *idCardText;

//验证码
- (IBAction)codeButtonClick:(id)sender;



- (IBAction)phoneChange:(id)sender;

- (IBAction)pwdChange:(id)sender;

- (IBAction)confirmPwdChange:(id)sender;

- (IBAction)verifyChange:(id)sender;

- (IBAction)idCardChange:(id)sender;

//是否勾选
- (IBAction)chooseBtnClick:(id)sender;


- (IBAction)registerBtnClick:(id)sender;

- (BOOL)validateIDCardNumber:(NSString *)value;

@end
