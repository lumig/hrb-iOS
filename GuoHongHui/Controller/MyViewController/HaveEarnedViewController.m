//
//  HaveEarnedViewController.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HaveEarnedViewController.h"
#import "productModel.h"
#import "holdingTableViewCell.h"
#import "LMModelManage.h"
#import "EmptyCarView.h"
@interface HaveEarnedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)EmptyCarView *emptyView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)productModel *info;
@end

@implementation HaveEarnedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"已收益";
    
     [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

#pragma mark --
#pragma mark -- delegate district

#pragma mark -- uitableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    holdingTableViewCell *cell = (holdingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"holdingTableViewCell" owner:self options:nil] lastObject];
    }
    
    [cell.waitingBTN setTitle:@"已收益" forState:UIControlStateNormal];
    
    [cell.productNameLabel setTextColor:[UIColor grayColor]];
    [cell.purchaseDateLabel setTextColor:[UIColor grayColor]];
    [cell.earningDateLabel setTextColor:[UIColor grayColor]];
    [cell.rateLabel setTextColor:[UIColor grayColor]];
    
    [cell cellFillWithProductModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [holdingTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)loadNetWorkData
{
    [self requestData];
}


#pragma mark --
#pragma mrak -- response event

- (void)requestData
{
    [[LMModelManage shareLLModelManage] getHavingEarnedDataWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            
            _dataArray = [dataArray mutableCopy];
        }
        
        if (_dataArray !=nil) {
            [self removeNetWorkErrorView];
            [self isHavingMess];
            [_tableView reloadData];
        }
    } failureBlock:^(BOOL state) {
        
        if (state) {
            [self showNetWorkErrorView:nil];
            
        }
    }];
}

- (void)isHavingMess
{
    if (_dataArray.count == 0) {
        
        [self addEmptyView];
    }
    else
    {
        [_emptyView removeFromSuperview];
    }
}


- (void)addEmptyView
{
    if (_emptyView == nil)
    {
        _emptyView = [[EmptyCarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    [self.view addSubview:_emptyView];
    [self.view sendSubviewToBack:_tableView];
}



#pragma mark --
#pragma mark -- setter and getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
