//
//  ResetViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

@interface ResetViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *codeTestField;

@property (weak, nonatomic) IBOutlet UITextField *nowPwdTestField;

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

- (IBAction)phoneChange:(id)sender;

- (IBAction)codeChange:(id)sender;

- (IBAction)nowPwdChange:(id)sender;

- (IBAction)codeBtnClick:(id)sender;

- (IBAction)FinishBtnClick:(id)sender;




@end
