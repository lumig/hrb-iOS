//
//  HZAreaPickerView.h
//  pickviewdemo
//
//  Created by mac on 15/7/6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"

typedef enum {
    HZAreaPickerWithStateAndCity,
    HZAreaPickerWithStateAndCityAndDistrict
} HZAreaPickerStyle;

@class HZAreaPickerView;

@protocol HZAreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker;
- (void)agreeButtonClick;
@end
@interface HZAreaPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (assign, nonatomic) id <HZAreaPickerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (strong, nonatomic) HZLocation *locate;
@property (nonatomic) HZAreaPickerStyle pickerStyle;

- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id <HZAreaPickerDelegate>)delegate;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
