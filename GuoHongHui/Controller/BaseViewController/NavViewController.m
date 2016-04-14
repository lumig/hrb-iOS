//
//  NavViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/6.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NavViewController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    
        self.navigationBar.barTintColor = RGBACOLOR(199, 0, 5, 1);
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor  whiteColor]};
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

-(void)backClicked:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
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
