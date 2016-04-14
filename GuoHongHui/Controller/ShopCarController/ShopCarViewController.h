//
//  ShopCarViewController.h
//  GuoHongHui
//
//  Created by mac on 15/7/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

@interface ShopCarViewController : BaseViewController

//判断购物车下方偏移
@property(nonatomic,assign)BOOL isAddShopCar;

@property(nonatomic,strong)NSMutableArray *goodsArray;
@end
