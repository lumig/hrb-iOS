//
//  GoodsBaseViewController.h
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsBaseViewController : BaseViewController

@property(nonatomic,strong)UILabel *huiAmountLabel;
@property(nonatomic,strong)UIButton *substractBtn;

@property(nonatomic,strong)UIButton *cartBtn;


- (void)substractBtnClick;
- (void)cartBtnClick;
@end
