//
//  holdingViewController.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "holdingViewController.h"
#import "holdingTableViewCell.h"
#import "productModel.h"
#import "LMModelManage.h"
#import "EmptyCarView.h"

@interface holdingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)EmptyCarView *emptyView;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation holdingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收益中";
    
    [self.view addSubview:self.tableView];
  
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
#pragma mark -- response event

- (void)requestData
{
    [[LMModelManage shareLLModelManage] getHoldingDataWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            self.dataArray = [dataArray mutableCopy];
        }
        
        if (_dataArray != nil) {
            
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
//        [self isHavingMessageToShow];
        
        
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
//        _emptyView = (EmptyCarView *)[[[NSBundle mainBundle]loadNibNamed:@"EmptyCarView" owner:self options:nil]lastObject];
//        _emptyView.frame = self.view.bounds;
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

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
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
