//
//  WaitingViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/8/16.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "WaitingViewController.h"
#import "InvestmentTableViewCell.h"
#import "productModel.h"
#import "LMModelManage.h"
@interface WaitingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)productModel *info;

@end

@implementation WaitingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预期待收益";
 
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark --
#pragma mark -- delegate district
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    InvestmentTableViewCell *cell = (InvestmentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentTableViewCell" owner:self options:nil] lastObject];
    }
    
    [cell cellFillWithProductModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InvestmentTableViewCell cellHeight];
}

#pragma mark --
#pragma mark -- response district

- (UIView *)addHeaderView
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    [imgView setImage:[UIImage imageNamed:@"APP_我的_10.png"]];
    
    [header addSubview:imgView];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, 12, 100, 20)];
    [titleLabel setText:@"预期待收益"];
    titleLabel.font = FONT14;
    CGFloat totalAmount =0;
    [header addSubview:titleLabel];
    for (productModel *model in _dataArray) {
        totalAmount += [model.totalInvestment floatValue];
    }
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 12, 140, 20)];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.font = FONT16;
    if (_dataArray == nil) {
        moneyLabel.text = [NSString stringWithFormat:@"0元"];
    }else
    {
    moneyLabel.text = [NSString stringWithFormat:@"%.2f元",totalAmount];
    }
    moneyLabel.textColor = GLOBAL_RedColor;
    [header addSubview:moneyLabel];
    
    return header;
}

- (void)requestData
{
    [[LMModelManage shareLLModelManage] getHoldingDataWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successBlock:^(BOOL state, NSMutableArray *dataArray) {
        
        if (state) {
            self.dataArray = [dataArray mutableCopy];
        }
        if (_dataArray != nil) {
//            [self removeNetWorkErrorView];
            _tableView.tableHeaderView = [self addHeaderView];
            [_tableView reloadData];
        }
    } failureBlock:^(BOOL state) {
        
        if (state) {
//            [self showNetWorkErrorView:nil];
        }
    }];
}

#pragma mark -- 
#pragma mark -- setter and getter
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    [_tableView reloadData];
    return _tableView;
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
