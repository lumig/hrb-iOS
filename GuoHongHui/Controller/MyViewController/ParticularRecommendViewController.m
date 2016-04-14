//
//  ParticularRecommendViewController.m
//  GuoHongHui
//
//  Created by mac on 15/6/30.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ParticularRecommendViewController.h"
#import "HuiRongBaoTableViewCell.h"
#import "LMModelManage.h"
#import "HuiRongBaoInfo.h"
#import "HuiProjectViewController.h"

@interface ParticularRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)LMModelManage *model;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ParticularRecommendViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"特别推荐";
    
    [self.view addSubview:self.tableView];
}

#pragma mark --
#pragma mark -- delegate district

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
    info = _dataArray[indexPath.section];
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
    HuiRongBaoInfo *info = _dataArray[section];
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
    info=_dataArray[indexPath.section];
    huiProjectVC.info = info;
    [self.navigationController pushViewController:huiProjectVC animated:YES];
}


- (void)loadNetWorkData
{
    [self requestData];
}

#pragma mark --
#pragma mark -- response event

- (void)requestData
{
    [self.model getRecommandDataWithView:self.view sucessBlock:^(BOOL state, NSMutableArray *dataArray) {
        self.dataArray = [dataArray mutableCopy];
        
        if (_dataArray !=nil) {
            [self removeNetWorkErrorView];
            [_tableView reloadData];
        }
    } failureBlock:^(BOOL state) {
        [self showNetWorkErrorView:nil];
    }];
}

#pragma mark --
#pragma mark -- setter and getter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (LMModelManage *)model
{
    if (_model == nil) {
        _model = [[LMModelManage alloc] init];
        
    }
    
    return _model;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
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
