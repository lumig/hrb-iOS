//
//  HuiOrderViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/6/23.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiOrderViewController.h"
#import "HeaderButtonView.h"
#import "BuyingTableViewCell.h"
#import "OrderInfo.h"
#import "LMModelManage.h"
#import "OrderModel.h"
#import "ConfirmOrderViewController.h"
#import "EmptyCarView.h"
#import "OrderViewController.h"

@interface HuiOrderViewController ()<HeaderButtonViewDelegate,UITableViewDelegate,UITableViewDataSource,BuyingTableViewCellDelegate>


@property(nonatomic,strong)HeaderButtonView *headerButtonView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)EmptyCarView *emptyView;
//备货中
@property(nonatomic,strong)UITableView *buyingTableView;
//发货中
@property(nonatomic,strong)UITableView *havingTableView;
//已签收
@property(nonatomic,strong)UITableView *signInTableView;
@property(nonatomic,assign)BOOL isBuyOrHaving;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)CGFloat allPrice;
@property(nonatomic,strong)NSMutableArray *allArray;
@property(nonatomic,assign)NSInteger index;
@end

@implementation HuiOrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"惠订单";
    
    [self.view addSubview:self.headerButtonView];
//    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.havingTableView];
    [self.view addSubview:self.signInTableView];
    [self.view addSubview:self.buyingTableView];
    [self requestData];
    
}

#pragma mark --
#pragma mark -- delegate district

#pragma mark -- UITableView delegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    BuyingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[BuyingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.delegate = self;
//    int row = indexPath.row;
    
    if (!_isBuyOrHaving)
    {
        
//        if ([_soArray count] > row)
//        {
        [cell fillWithOrderModel:_dataArray[indexPath.row] indexRow:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //        }
        _allPrice = 0.0;
        OrderModel *model = [[OrderModel alloc] init];
        model = _dataArray[indexPath.row];
        NSArray *array = [NSArray array];
        array = model.orderArray;
        for (NSDictionary *dict in array) {
            _allPrice +=  [dict[@"price"] floatValue] * [dict[@"num"] integerValue] ;
        }
        
        cell.orderTotalLabel.text =[NSString stringWithFormat:@"订单金额：%.0f",_allPrice];
        [cell.rightBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    else
//    {
////        if ([_attentionArray count] > row)
////        {
//             [cell fillWithOrderInfo:self.info1];
//        [cell.rightBtn setTitle:@"再次购买" forState:UIControlStateNormal];
////        }
//    }
   
    

    
    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 15;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cell height %f",[BuyingTableViewCell heightForCell]);
    return [BuyingTableViewCell heightForCell];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyingTableViewCell *cell = (BuyingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    ConfirmOrderViewController *confirmVC = [[ConfirmOrderViewController alloc] init];
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    OrderModel *model = [[OrderModel alloc] init];
    model = _dataArray[indexPath.row];
    NSArray *array = [NSArray array];
    array = model.orderArray;
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        NSMutableDictionary *eachDict = [NSMutableDictionary dictionary];
        [eachDict setValue:[dict objectForKey:@"num"] forKey:@"goodsNum"];
        [eachDict setValue:[dict objectForKey:@"price"] forKey:@"huiPrice"];
        [eachDict setValue:[dict objectForKey:@"productName"] forKey:@"goodsTitle"];
        [eachDict setValue:[dict objectForKey:@"productIdUrl"] forKey:@"imgStr"];
        [goodsArray addObject:eachDict];
    }
    
//    confirmVC.goodsArray = goodsArray;
    [[NSUserDefaults standardUserDefaults] setObject:goodsArray forKey:@"buyArray"];
    orderVC.allPrice = [NSString stringWithFormat:@"%.0f",_allPrice];
    orderVC.logisticsId = model.logisticsId;
    orderVC.orderId = model.orderId;
    orderVC.typeStr = model.orderType;
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark -- buyingtableviewdelegate

- (void)buyingButtonClickWithIndex:(NSInteger)index
{
    ConfirmOrderViewController *confirmVC = [[ConfirmOrderViewController alloc] init];
    _allPrice = 0.0;
    OrderModel *model = [[OrderModel alloc] init];
    model = _dataArray[index];
    NSArray *array = [NSArray array];
    array = model.orderArray;
    for (NSDictionary *dict in array) {
        _allPrice +=  [dict[@"price"] floatValue] * [dict[@"num"] integerValue] ;
    }
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        NSMutableDictionary *eachDict = [NSMutableDictionary dictionary];
        [eachDict setValue:[dict objectForKey:@"num"] forKey:@"goodsNum"];
        [eachDict setValue:[dict objectForKey:@"price"] forKey:@"huiPrice"];
        [eachDict setValue:[dict objectForKey:@"productName"] forKey:@"goodsTitle"];
        [eachDict setValue:[dict objectForKey:@"productIdUrl"] forKey:@"imgStr"];
        [goodsArray addObject:eachDict];
    }
    
//    confirmVC.goodsArray = goodsArray;
     [[NSUserDefaults standardUserDefaults] setObject:goodsArray forKey:@"buyArray"];
    confirmVC.allPrice = [NSString stringWithFormat:@"%.0f",_allPrice];
    
    [self.navigationController pushViewController:confirmVC animated:YES];

}


#pragma mark --
- (void)headerButtonClick:(NSUInteger)index
{
   
//    _isBuyOrHaving = index;
    
    [self.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:NO];
    
    switch (index) {
        case 0:
        {
            _index = 0;
            [self requestData];
            _buyingTableView.hidden = NO;
            _havingTableView.hidden=YES;
            _signInTableView.hidden = YES;
        }
            break;
        case 1:
        {
            _index = 1;
            [self requestShippedData];
            _havingTableView.hidden = NO;
            _buyingTableView.hidden = YES;
            _signInTableView.hidden = YES;
        }
            break;
        case 2:
        {
            _index = 2;
            [self requestRecivedData];
            _signInTableView.hidden = NO;
            _buyingTableView.hidden = YES;
            _havingTableView.hidden = YES;
        }
            break;
            
        default:
            break;
    }
//    if (!_isBuyOrHaving)
//    {
//        if ([_soArray count] == 0)
//        {
//            [_buyingTableView reloadData];
//            [_buyingTableView headerBeginRefreshing];
//        }else
//        {
//            [_buyingTableView reloadData];
//        }
//    }
//    else
//    {
//        if ([_attentionArray count] == 0)
//        {
//            [_havingTableView reloadData];
//            [_havingTableView headerBeginRefreshing];
//        }else
//        {
//            [_havingTableView reloadData];
//        }
//    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
        float ox = scrollView.contentOffset.x / iphone.width;
        
        [self.headerButtonView currentSelectButton:(int)ox];
    
}

- (void)loadNetWorkData
{
    switch (_index) {
        case 0:
        {
            [self requestData];
        }
            break;
        case 1:
        {
            [self requestShippedData];
        }
            break;
        case 2:
        {
            [self requestRecivedData];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark --
#pragma mark -- event response

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
- (void)requestData
{
    [[LMModelManage shareLLModelManage] getOrderDataWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            [_dataArray removeAllObjects];
            self.dataArray = [dataArray mutableCopy];
            if (_dataArray != nil) {
                [self removeNetWorkErrorView];
                [self isHavingMess];
                [_buyingTableView reloadData];
            }
            
        }
    } failureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    }];
    
   
}
- (void)requestShippedData
{
    [[LMModelManage shareLLModelManage] getShippedOrderWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            [_dataArray removeAllObjects];
            self.dataArray = [dataArray mutableCopy];
            if (_dataArray != nil) {
                [self removeNetWorkErrorView];
                [self isHavingMess];
                [_havingTableView reloadData];
                
            }
            
        }
    } failureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    }];
}
- (void)requestRecivedData
{
    [[LMModelManage shareLLModelManage] getReceivedOrderWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"]   successBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            [_dataArray removeAllObjects];
            self.dataArray = [dataArray mutableCopy];
            if (_dataArray != nil) {
                [self removeNetWorkErrorView];
                [self isHavingMess];
                [_signInTableView reloadData];                
            }
            
        }
    } failureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    }];

}

- (void)addEmptyView
{
    if (_emptyView == nil)
    {
        _emptyView = [[EmptyCarView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    [self.view addSubview:_emptyView];
    [self.view sendSubviewToBack:_buyingTableView];
}


#pragma mark --
#pragma mark -- setter and getter

- (HeaderButtonView *)headerButtonView
{
    if (_headerButtonView  == nil) {
        
        _headerButtonView = [[HeaderButtonView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44) titleArray:@[@"备货中",@"发货中",@"已签收"] imageArray:nil];
        
        _headerButtonView.delegate = self;
    }
    
    return _headerButtonView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
        _scrollView.delegate = self;
        
        _scrollView.pagingEnabled = YES;
        _scrollView.tag = 100;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(3 * SCREEN_WIDTH, 0);
    }
    return _scrollView;
}


- (UITableView *)buyingTableView
{
    if (_buyingTableView == nil) {
        
        _buyingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT-113 )];
        _buyingTableView.delegate = self;
        _buyingTableView.dataSource = self;
        _buyingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _buyingTableView;
}

- (UITableView *)havingTableView
{
    if (_havingTableView == nil) {
        
        _havingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT - 113)];
        
        _havingTableView.delegate = self;
        _havingTableView.dataSource = self;
        _havingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _havingTableView;
}
- (UITableView *)signInTableView
{
    if (_signInTableView == nil) {
        _signInTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, SCREEN_HEIGHT - 113)];
    }
    _signInTableView.delegate =self;
    _signInTableView.dataSource = self;
    _signInTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _signInTableView;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)allArray
{
    if (_allArray == nil) {
        _allArray = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _allArray;
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
