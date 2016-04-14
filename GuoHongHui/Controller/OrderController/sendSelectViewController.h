//
//  sendSelectViewController.h
//  GuoHongHui
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//配送方式

#import "BaseViewController.h"

@interface sendSelectViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *selectBtn1;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn2;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn3;


@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSArray *addressArray;
@property(nonatomic,strong)NSArray *sendTimeArray;


- (IBAction)confirmBtnClick:(id)sender;

@end
