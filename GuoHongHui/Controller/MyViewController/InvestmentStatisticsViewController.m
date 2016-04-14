//
//  InvestmentStatisticsViewController.m
//  GuoHongHui
//
//  Created by mac on 15/6/30.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "InvestmentStatisticsViewController.h"
#import "InvestmentTableViewCell.h"
#import "InvestmentSectionCell.h"
#import "productModel.h"
#import "EmptyCarView.h"
#import "LMModelManage.h"

@interface InvestmentStatisticsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)EmptyCarView *emptyView;
@property(nonatomic,strong)NSDictionary *dataDict;
@property(nonatomic,strong)NSMutableArray *holdingArray;
@property(nonatomic,strong)NSMutableArray *earnedArray;

@property(nonatomic,strong)productModel *info;

@end

@implementation InvestmentStatisticsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"投资统计";
    [self.view addSubview:self.tableView];
    
}


#pragma mark -- 
#pragma mark -- delegate district
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else if(section == 1)
    {
    return _earnedArray.count;
    }
    else
    {
        return _holdingArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    InvestmentTableViewCell *cell = (InvestmentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentTableViewCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section == 0) {
        return nil;
    }
    else if (indexPath.section == 1)
    {
        [cell cellFillWithProductModel:_earnedArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        [cell cellFillWithProductModel:_holdingArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InvestmentTableViewCell cellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    InvestmentSectionCell *sectionCell = [[[NSBundle mainBundle] loadNibNamed:@"InvestmentSectionCell" owner:self options:nil] lastObject];
    sectionCell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [header addSubview:sectionCell];
    CGFloat holdingSum = 0;
    CGFloat earningSum = 0;
    CGFloat totalSum = 0;
    for (productModel *model in _holdingArray) {
        holdingSum += [model.totalInvestment floatValue];
    }
    for (productModel *model in _earnedArray) {
        earningSum += [model.totalInvestment floatValue];
    }
    totalSum = holdingSum + earningSum;
    if (section == 0) {
        
        [sectionCell.imgView setImage:[UIImage imageNamed:@"APP_我的_03.png"]];
        [sectionCell.nameLabel setText:@"投资总额"];
        if (_dataDict == nil) {
          [sectionCell.dataLabel setText:[NSString stringWithFormat:@"0元"]];
        }else
        {
        [sectionCell.dataLabel setText:[NSString stringWithFormat:@"%.2f元",totalSum]];
        }
        sectionCell.backgroundColor = [UIColor whiteColor];
    }
    else if(section == 1)
    {
        [sectionCell.imgView setImage:[UIImage imageNamed:@"APP_投资统计_03.png"]];
        [sectionCell.nameLabel setText:@"已收款总额"];
        if (_earnedArray ==nil) {
           [sectionCell.dataLabel setText:[NSString stringWithFormat:@"0元"]];
        }
        else
        {
        [sectionCell.dataLabel setText:[NSString stringWithFormat:@"%.2f元",earningSum]];
        }
        sectionCell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        [sectionCell.imgView setImage:[UIImage imageNamed:@"APP_我的_10.png"]];
        [sectionCell.nameLabel setText:@"待收款总额"];
        if (_holdingArray == nil) {
           [sectionCell.dataLabel setText:[NSString stringWithFormat:@"0元"]];
        }
        [sectionCell.dataLabel setText:[NSString stringWithFormat:@"%.2f元",holdingSum]];
        sectionCell.backgroundColor = [UIColor whiteColor];
    }
    
    return header;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}



#pragma mark -- scrollview delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 44; //section的高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

#pragma mark --
#pragma mark -- event response


- (void)isHavingMess
{
    if (_holdingArray.count == 0) {
        
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


- (void)requestData
{
    [[LMModelManage shareLLModelManage] getInvestRecordDataWithView:self.view  idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successBlcok:^(BOOL state, NSMutableDictionary *dataDict) {
        if (state) {
            self.dataDict = [dataDict mutableCopy];
            
            if (_dataDict !=nil) {
                self.earnedArray = [_dataDict objectForKey:@"earnedValue"];
                self.holdingArray = [_dataDict objectForKey:@"holdingValue"];

                [_tableView reloadData];
              }
        }
        
    } failureBlock:^(BOOL state) {
        
    }];
    
}

#pragma mark -- 
#pragma mark -- setter and getter

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}
- (NSDictionary *)dataDict
{
    if (_dataDict == nil) {
        _dataDict = [NSDictionary dictionary];
    }
    return _dataDict;
}

- (NSMutableArray *)earnedArray
{
    if (_earnedArray == nil) {
        _earnedArray = [NSMutableArray array];
    }
    return _earnedArray;
}
- (NSMutableArray *)holdingArray
{
    if (_holdingArray ==nil){
        _holdingArray = [NSMutableArray array];
    }
    return _holdingArray;
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
