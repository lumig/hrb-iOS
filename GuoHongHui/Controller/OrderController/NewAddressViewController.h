//
//  NewAddressViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"
@interface NewAddressViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *consigneeText;

@property (weak, nonatomic) IBOutlet UITextField *cellPhoneText;


@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UITextField *detailAddressText;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

- (IBAction)selectAddressBtnClick:(id)sender;


- (IBAction)confirmBtnClick:(id)sender;


@end
