//
//  MainViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//
//TabBar控制器

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ProjectViewController.h"
#import "MyViewController.h"
#import "SettingViewController.h"
#import "HuiRongBaoViewController.h"
#import "NavViewController.h"
#import "ShopCarViewController.h"
#import "GHStringManger.h"
#import "HuiWorldViewController.h"


@interface MainViewController ()
@property(nonatomic,strong)HomeViewController *homeVC;
@property(nonatomic,strong)HuiRongBaoViewController *huiRongBaoVC;
@property(nonatomic,strong)MyViewController *MyVC;
@property(nonatomic,strong)SettingViewController *settingVC;
@property(nonatomic,strong)ShopCarViewController *shopCarVC;
@property(nonatomic,strong)HuiWorldViewController *huiWorldVC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBarItems];
    
    [self.view addSubview:self.badgeLabel];
    
    NSLog(@"thebadge %@",self.badgeLabel.text);
}

#pragma mark --
#pragma mark -- Event Response

- (void)createTabBarItems
{
    _homeVC = [[HomeViewController alloc] init];
    NavViewController *homeNav = [[NavViewController alloc] initWithRootViewController:_homeVC];
    UIImage *selectHomeImg = [UIImage imageNamed:@"tabbar_click_03.png"];
    selectHomeImg = [selectHomeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_03.png"] selectedImage:selectHomeImg];
    [self unselectedTabBarItem:_homeVC.tabBarItem];
    [self selectedTabBatItem:_homeVC.tabBarItem];
    
    _huiRongBaoVC = [[HuiRongBaoViewController alloc] init];
    NavViewController *huiRongBaoNav = [[NavViewController alloc] initWithRootViewController:_huiRongBaoVC];
    UIImage *selectHuiImg = [UIImage imageNamed:@"tabbar_click_11.png"];
    selectHuiImg = [selectHuiImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _huiRongBaoVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"惠融宝" image:[UIImage imageNamed:@"tabbar_11.png"] selectedImage:selectHuiImg];
    [self unselectedTabBarItem:_huiRongBaoVC.tabBarItem];
    [self selectedTabBatItem:_huiRongBaoVC.tabBarItem];
    
    _shopCarVC = [[ShopCarViewController alloc] init];
    NavViewController *shopCarNav = [[NavViewController alloc] initWithRootViewController:_shopCarVC];
    UIImage *selectShopImg = [UIImage imageNamed:@"i_tool_cart_on.png"];
    selectShopImg = [selectShopImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _shopCarVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车"image:[UIImage imageNamed:@"i_tool_cart_off.png"] selectedImage:selectShopImg];
    [self unselectedTabBarItem:_shopCarVC.tabBarItem];
    [self selectedTabBatItem:_shopCarVC.tabBarItem];
    
    _huiWorldVC = [[HuiWorldViewController alloc] init];
    NavViewController *huiWorldNav = [[NavViewController alloc] initWithRootViewController:_huiWorldVC];
    UIImage *selectHuiWorldImg = [UIImage imageNamed:@"tabbar_click_13.png"];
    selectHuiWorldImg = [selectHuiWorldImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _huiWorldVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"惠世界"image:[UIImage imageNamed:@"tabbar_13.png"] selectedImage:selectHuiWorldImg];
    [self unselectedTabBarItem:_huiWorldVC.tabBarItem];
    [self selectedTabBatItem:_huiWorldVC.tabBarItem];
    
    _MyVC = [[MyViewController alloc] init];
    NavViewController *myNav = [[NavViewController alloc] initWithRootViewController:_MyVC];
    UIImage *selectMyImg = [UIImage imageNamed:@"tabbar_click_05.png"];
    selectMyImg = [selectMyImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _MyVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_05.png"] selectedImage:selectMyImg];
    [self unselectedTabBarItem:_MyVC.tabBarItem];
    [self selectedTabBatItem:_MyVC.tabBarItem];
    
    _settingVC = [[SettingViewController alloc] init];
    NavViewController *settingNav = [[NavViewController alloc] initWithRootViewController:_settingVC];
    UIImage *selectSettingImg = [UIImage imageNamed:@"tabbar_click_08.png"];
    selectSettingImg = [selectSettingImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _settingVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"tabbar_08.png"] selectedImage:selectSettingImg];
    [self unselectedTabBarItem:_settingVC.tabBarItem];
    [self selectedTabBatItem:_settingVC.tabBarItem];
    
    self.viewControllers = [NSArray arrayWithObjects:homeNav, huiRongBaoNav,huiWorldNav,myNav,settingNav, nil];
    
}


- (void)unselectedTabBarItem:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT13, NSFontAttributeName, [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}

- (void)selectedTabBatItem:(UITabBarItem *)tabBarItem
{
    
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        FONT13,
                                        NSFontAttributeName,RGBACOLOR(215, 29, 21, 1),NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}

- (void)setBadgeString:(NSString *)badgeString
{
    if ([badgeString isEqualToString:@"0"]) {
        self.badgeLabel.frame = CGRectMake(0, 0, 0, 0);
        return;
    }
    
    CGFloat badgeWidth = [GHStringManger stringBoundingRectWithSize:CGSizeMake(100, 20) font:FONT13 text:badgeString].width;
    
    badgeWidth += 10;
    
    if (badgeWidth < 20)
    {
        badgeWidth = 20;
    }
    
    
    self.badgeLabel.frame = CGRectMake(FRAME_WIDTH * 5 / 10 + 7, FRAME_HEIGHT - 46, badgeWidth, 20);
    
    self.badgeLabel.text = badgeString;
}

#pragma mark --
#pragma mark -- setter and getter

- (void)setGoodsNumber:(NSString *)goodsNumber
{
    //获取goods个数
    
    [self setBadgeString:goodsNumber];
}

- (UILabel *)badgeLabel
{
    if (_badgeLabel == nil)
    {
        _badgeLabel = [[UILabel alloc]init];
        
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        
        _badgeLabel.textColor = [UIColor whiteColor];
        
        _badgeLabel.font = FONT13;
        _badgeLabel.layer.cornerRadius = 10;
//        _badgeLabel.layer.borderWidth = 2;
        _badgeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.backgroundColor = COLOR_BADGE;
    }
    
    return _badgeLabel;
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
