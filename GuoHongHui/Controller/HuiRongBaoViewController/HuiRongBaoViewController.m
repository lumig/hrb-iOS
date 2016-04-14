//
//  HuiRongBaoViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiRongBaoViewController.h"

#import "HuiRongBaoTableViewCell.h"
#import "HuiProjectViewController.h"
#import "HuiRongBaoModel.h"
#import "HuiRongBaoInfo.h"
#import <UIImageView+AFNetworking.h>

@interface HuiRongBaoViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)HuiRongBaoModel *model;
@property(nonatomic,strong)HuiRongBaoInfo *info;
@property(nonatomic,strong)NSMutableArray *huiArray;
@property(nonatomic,strong)NSArray *sectionImgArray;
@property(nonatomic,strong)NSArray *imgArray;
@property(nonatomic,strong)NSArray *investLimitArray;
@property(nonatomic,strong)NSArray *earnMethodArray;

@end

@implementation HuiRongBaoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"惠融宝";
    [self.view addSubview:self.tableView];
    
   }


#pragma mark --
#pragma mark -- delegate district

#pragma mark --
#pragma mark --  UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _huiArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID= @"cellID";
    HuiRongBaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HuiRongBaoTableViewCell" owner:self options:nil] lastObject];
    }
    HuiRongBaoInfo *info = [[HuiRongBaoInfo alloc] init];
    info = _huiArray[indexPath.section];
    [cell.imgView setImageWithURL:[NSURL URLWithString:info.huiRateImg] placeholderImage:GHSMALLIMAGE];
    cell.investLimtLabel.text = [NSString stringWithFormat:@"%@个月",info.huiLimit];
    cell.limitMoneyLabel.text = [NSString stringWithFormat:@"%@",info.huiMoney];
    cell.earnMethodLabel.text = info.increaseMethod;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 90, 20)];
    HuiRongBaoInfo *info = _huiArray[section];
    [imgView setImageWithURL:[NSURL URLWithString:info.huiNameImg] placeholderImage:GHSMALLIMAGE] ;
    
    [header addSubview:imgView];
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HuiProjectViewController *huiProjectVC = [[HuiProjectViewController alloc] init];
    HuiRongBaoInfo *info = [[HuiRongBaoInfo alloc] init];
    info=_huiArray[indexPath.section];
    huiProjectVC.info = info;
    [self.navigationController pushViewController:huiProjectVC animated:YES];
}


#pragma mark --
#pragma mark -- event response
- (void)requestData
{
    [self.model getHuirongbaoDataWithView:self.view HuirongbaoBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            self.huiArray = [dataArray mutableCopy];
            
            [_tableView reloadData];
        }
    } failureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    } ];

}



#pragma mark --
#pragma mark -- setter and getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HuiRongBaoModel *)model
{
    if (_model == nil) {
        _model = [[HuiRongBaoModel alloc] init];
        
    }
    return _model;
}

- (HuiRongBaoInfo *)info
{
    if (_info == nil) {
        _info = [[HuiRongBaoInfo alloc] init];
    }
    return _info;
}

-(NSMutableArray *)huiArray
{
    if (_huiArray == nil) {
        _huiArray = [NSMutableArray array];
    }
    return _huiArray;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
