//
//  HuiWorldViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiWorldViewController.h"
#import "EScrollerView.h"
#import "homeGoodsCell.h"
#import "GoodsDetailsViewController.h"
#import "HuiWorldModel.h"

#define eScrollHeight  ([UIScreen mainScreen].bounds.size.width == 320 ? 170:200)
@interface HuiWorldViewController ()<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate>
@property(nonatomic,strong)EScrollerView *eScrollerView ;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)HuiWorldModel *huiWorldModel;
@property(nonatomic,strong)NSMutableDictionary *huiDict;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)goodsDetailInfo *goodsInfo;

@property(nonatomic,strong)NSMutableArray *huiGoodsArray;

@end

@implementation HuiWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"惠世界";

    [self.view addSubview:self.tableView];
    
     
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
    self.tabBarController.tabBar.hidden = NO;
    
    
}

#pragma mark --
#pragma mark -- delegate district
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_huiGoodsArray count] / 2 + [_huiGoodsArray count] % 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    homeGoodsCell *cell = (homeGoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[homeGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if ([_huiGoodsArray count]>indexPath.row *2) {
        
        BOOL rightFlag = [_huiGoodsArray count] > indexPath.row * 2 + 1;
        [cell cellFillLeftModel:[_huiGoodsArray objectAtIndex:indexPath.row*2] leftRow:indexPath.row*2 rightModel:rightFlag ? [_huiGoodsArray objectAtIndex:indexPath.row*2 + 1]:nil rightRow:indexPath.row*2 + 1];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [homeGoodsCell cellHeight];
}

#pragma mark --
#pragma mark -- 路有消息
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    
   if ([eventName isEqualToString:GHHOMEGOODS_ROUTEREVENT]) {
        
        NSUInteger row = [[userInfo objectForKey:@"row"] integerValue];
        
        if ([_huiGoodsArray count] > row)
        {
            goodsDetailInfo *info = [_huiGoodsArray objectAtIndex:row];
            
            GoodsDetailsViewController *goodsDetailVC = [[GoodsDetailsViewController alloc] init];
            goodsDetailVC.goodsID = info.goodsID;
            [self.navigationController pushViewController:goodsDetailVC animated:YES];
        }
    }
 
}

#pragma mark -- EScrollerViewDelegate
- (void)EScrollerViewDidClicked:(NSUInteger)index
{
    
}

#pragma mark --
#pragma mark -- response event

- (UIView *)addHeaderView
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, eScrollHeight + 10)];
    
    [header addSubview:self.eScrollerView];
    
    return header;
    
}
- (void)getData
{
    [self.huiWorldModel getHuiWorldDataWithView:self.view HuiWorldBlock:^(BOOL state, NSMutableDictionary *dataDict) {
        if (state) {
            self.huiDict = [dataDict mutableCopy];
            
        }
        
        if (_huiDict !=nil) {
            self.imageArray = [_huiDict objectForKey:@"imageUrl"];
            self.huiGoodsArray = [_huiDict objectForKey:@"goodsArray"];
            _tableView.tableHeaderView = [self addHeaderView];
            
            [self removeNetWorkErrorView];
            [_tableView  reloadData];
        }
        
    } failureBlock:^(BOOL state) {
        
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    } ];

}

- (void)loadNetWorkData
{
    [self getData];
}
#pragma mark --
#pragma mark -- setter and getter

- (EScrollerView *)eScrollerView
{
    if (_eScrollerView == nil) {
        _eScrollerView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, eScrollHeight) ImageArray:_imageArray TitleArray:nil autoPlay:YES];
        
        
        _eScrollerView.delegate = self;
    }
    
    return _eScrollerView;
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

- (HuiWorldModel *)huiWorldModel
{
    if (_huiWorldModel == nil) {
        
        _huiWorldModel = [[HuiWorldModel alloc] init];
    }
    
    return _huiWorldModel;
}
- (NSMutableDictionary *)huiDict
{
    if (_huiDict == nil) {
        _huiDict = [NSMutableDictionary dictionary];
    }
    
    return _huiDict;
}
- (NSMutableArray *)imageArray

{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)huiGoodsArray
{
    if (_huiGoodsArray == nil) {
        _huiGoodsArray = [[NSMutableArray alloc] init];
    }
    return _huiGoodsArray;
    
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
