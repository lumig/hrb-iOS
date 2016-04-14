//
//  FeedBackViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^FeedBackBlock)(BOOL state);

@interface FeedBackViewController : BaseViewController

@property(nonatomic,copy)FeedBackBlock feedBackBlock;

@property (weak, nonatomic) IBOutlet UITextView *TextView;

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)SubmitClick:(id)sender;


@end
