//
//  NewAddressViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "NewAddressViewController.h"
#import "HZAreaPickerView.h"
#import "ConfirmOrderViewController.h"

@interface NewAddressViewController ()<UITextFieldDelegate,HZAreaPickerDelegate>

@property(nonatomic,strong)HZAreaPickerView *localPickView;

@property(nonatomic,strong)NSString *areaValue;
@end

@implementation NewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建地址";
    
    self.confirmBtn.layer.cornerRadius = 6;
    
    [self addLeftBtn];
    
    
    
    
    self.cellPhoneText.keyboardType = UIKeyboardTypePhonePad;
    
    self.localPickView.pickerStyle = HZAreaPickerWithStateAndCityAndDistrict;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressClick:)];
//    
//    [self.addressLabel addGestureRecognizer:tap];
//    self.addressLabel.userInteractionEnabled = YES;
 
    self.detailAddressText.delegate = self;
    
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateSelected];
}



#pragma mark --
#pragma mark -- delegate district

#pragma mark -- HZAreaPicker delegate
- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    }
   
    
//    self.addressText.text = self.areaValue;
    
    self.addressLabel.text = self.areaValue;
    
}

#pragma mark - TextField delegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    return YES;
//}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    if ([textField isEqual: self.addressText]) {
//        
//        [textField resignFirstResponder ];
//        
//        [[[UIApplication sharedApplication] keyWindow] endEditing:NO];
//        
//        [self cancelLocatePicker];
//        self.localPickView = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] ;
//        [self.localPickView showInView:self.view];
//        
//    }
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}

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
#pragma mark -- response event
- (void)addLeftBtn
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22.5, 24)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"i_arrow_white_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
}

#pragma mark -- buttonClick

- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addressClick:(UITapGestureRecognizer *)tap
{
    self.localPickView = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] ;
    [self.localPickView showInView:self.view];
    
}

-(void)cancelLocatePicker
{
    [self.localPickView cancelPicker];
    self.localPickView.delegate = nil;
    self.localPickView = nil;
}

- (void)agreeButtonClick
{
    [self cancelLocatePicker];
    
}

- (IBAction)selectAddressBtnClick:(id)sender {
    
    self.localPickView = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] ;
    //注意细节
    self.localPickView.frame = CGRectMake(0, SCREEN_HEIGHT - 250, SCREEN_WIDTH, 250);
    [self.localPickView showInView:self.view];
}

- (IBAction)confirmBtnClick:(id)sender {
    
    if (![self.addressLabel.text isEqualToString:@""]&&![self.cellPhoneText.text isEqualToString:@""]&&![self.consigneeText.text isEqualToString:@""]&&![self.detailAddressText.text isEqualToString:@""]) {
        
        NSDictionary *addressDic=@{@"Consignee":self.consigneeText.text,@"CellPhone":self.cellPhoneText.text,@"address":[NSString stringWithFormat:@"%@%@",self.addressLabel.text,self.detailAddressText.text]};
        [[NSUserDefaults standardUserDefaults] setObject:self.addressLabel.text forKey:@"iAddress"];
        [[UserInfo shareUserInfo] saveLocationAddress:addressDic];
        [[UserInfo shareUserInfo]saveExpressName:@""];
        [[UserInfo shareUserInfo]saveSendGoodsTime:@""];
        [[NSUserDefaults standardUserDefaults] setObject:self.addressLabel.text forKey:@"iAddress"];

        
    }
    ConfirmOrderViewController *confirmVC = [[ConfirmOrderViewController alloc] init];
    
    [self.navigationController pushViewController:confirmVC animated:YES];
  
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
