//
//  BuyRecordsViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BuyRecordsViewController.h"
#import "BuyRecordsTableViewCell.h"
#import "BuyDateModel.h"
#import "SendGoodsTableViewCell.h"
#import "LMModelManage.h"
#import "EmptyCarView.h"


@interface BuyRecordsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)EmptyCarView *emptyView;
@end


@implementation BuyRecordsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"换购记录";
    
    [self.view addSubview:self.tableView];
    
}


#pragma mark --
#pragma mark -- delegate district
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return _dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    BuyRecordsTableViewCell *cell = (BuyRecordsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BuyRecordsTableViewCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section == 0) {
        BuyDateModel *info = [[BuyDateModel alloc] init];
        info.type = @"-1";
        [cell cellFillWithBuyDateModel:info];
        return cell;
    }
    
    else
    {
        [cell cellFillWithBuyDateModel:_dataArray[indexPath.row]];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [BuyRecordsTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
}

#pragma mark --
#pragma mark -- response event
- (void)requestData
{
    [[LMModelManage shareLLModelManage] getBuyRecordDataWithView:self.view goodsId:_goodsId successBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            self.dataArray = [dataArray mutableCopy];
            if (_dataArray !=nil) {
                [self removeNetWorkErrorView];
                [self isHavingMess];
                [_tableView reloadData];
            }
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
-(UITableView *)tableView
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
