//
//  ConfirmOrderViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//换购订单
#import "BaseViewController.h"

@interface ConfirmOrderViewController : BaseViewController


@property(nonatomic,strong)UILabel *huiAmountLabel;
@property(nonatomic,strong)NSString *totalPayStr;
@property(nonatomic,strong)UIButton *substractBtn;
@property(nonatomic,strong)NSArray *goodsArray;
@property(nonatomic,strong)NSString *allPrice;
@property(nonatomic,assign)BOOL isSuccess;
@end
