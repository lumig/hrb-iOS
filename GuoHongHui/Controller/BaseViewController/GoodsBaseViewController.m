//
//  GoodsBaseViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "GoodsBaseViewController.h"
#import "GHStringManger.h"
@interface GoodsBaseViewController ()


@end

@implementation GoodsBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBottomView];
}


- (void)setBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    bottomView.backgroundColor = TOPBACKGOUDCOLOR;
    [self.view addSubview:bottomView];
    
    
    UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    topImgView.backgroundColor = GLOBAL_GrayColor;
    [bottomView addSubview:topImgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13, [GHStringManger stringBoundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 24) font:FONT13 text:@"惠特价："].width, 24)];
    nameLabel.text = @"惠特价：";
    nameLabel.font = FONT13;
    [bottomView addSubview:nameLabel];
    
    _huiAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) , 13, 200, 24)];
    _huiAmountLabel.textColor = GLOBAL_RedColor;
    _huiAmountLabel.font = FONT16;
    _huiAmountLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:_huiAmountLabel];
    
    _substractBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, 10, [GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 30) font:FONT16 text:@"加入购物车"].width, 30)];
    _substractBtn.backgroundColor = GLOBAL_RedColor;
    [_substractBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [_substractBtn.titleLabel setFont:FONT16];
    [_substractBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    
    _cartBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_substractBtn.frame) + 10,6, 32, 32)];
    [_cartBtn setImage:[UIImage imageNamed:@"i_cart.png"] forState:UIControlStateNormal];
    [bottomView addSubview:_cartBtn];
    [_cartBtn addTarget:self action:@selector(cartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _substractBtn.layer.cornerRadius = 6;
    _substractBtn.layer.masksToBounds = YES;
    
    [_substractBtn addTarget:self action:@selector(substractBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_substractBtn];
}

- (void)substractBtnClick
{
    
}

- (void)cartBtnClick
{
    
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
