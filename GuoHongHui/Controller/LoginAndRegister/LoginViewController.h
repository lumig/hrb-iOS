//
//  LoginViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"
@protocol LoginDelegate <NSObject>
- (void)loginSuccess;
@optional
- (void)loginOrRegisterFailure;
@end

@interface LoginViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *pswTestField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property(nonatomic,assign)NSInteger type;

@property (nonatomic , assign) id <LoginDelegate>delegate;
- (IBAction)nameChanged:(id)sender;

- (IBAction)pswChanged:(id)sender;

- (IBAction)loginClick:(id)sender;

- (IBAction)reSetBtnClick:(id)sender;

- (IBAction)registerBtnClick:(id)sender;

- (id)initWithDelegate:(id)delegate;


@end
