//
//  ModifyPswViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyPswViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldTextField;


@property (weak, nonatomic) IBOutlet UITextField *nowTextField;


@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)submitClick:(id)sender;

- (IBAction)oldChang:(id)sender;

- (IBAction)newChange:(id)sender;

- (IBAction)confirmChange:(id)sender;


@end
