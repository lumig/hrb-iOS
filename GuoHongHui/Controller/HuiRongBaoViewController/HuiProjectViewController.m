//
//  HuiProjectViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/16.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HuiProjectViewController.h"
#import "HuiProjectIntroduceView.h"
#import "HeaderButtonView.h"
#import "InvestorRecordTableViewCell.h"
#import "investorRecordModel.h"
#import "HuiListModel.h"
#import "LMModelManage.h"
#import "GHStringManger.h"
#import "EmptyCarView.h"

#define kGap (SCREEN_WIDTH==320.0 ? 10:15)
#define emptyViewHeight  ([UIScreen mainScreen].bounds.size.width == 320 ? -70:-100)
@interface HuiProjectViewController ()<UITableViewDataSource,UITableViewDelegate,HeaderButtonViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)HuiListModel *model;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)HuiProjectIntroduceView *huiView;
@property(nonatomic,strong)HeaderButtonView *headerButtonView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UITableView *projectIntroTableView;
@property(nonatomic,strong)UITableView *projectRecordTableView;
@property(nonatomic,strong)EmptyCarView *emptyView;
@property(nonatomic,assign)BOOL isIntroAndRecord;
@end

@implementation HuiProjectViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"产品说明";
    
    [self addHuiView];
    
    [self.view addSubview:self.headerButtonView];
    
//    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.projectRecordTableView];
    [self.view addSubview:self.projectIntroTableView];

}


#pragma mark --
#pragma mark -- delegate district

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (tableView == _projectRecordTableView) {
//        return 2;
//    }
//    else
//    {
//    return 1;
//    }
    if (!_isIntroAndRecord) {
        return 1;
    }else
    {
        return 2;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _projectRecordTableView ) {
       
        if (section == 0) {
            return 1;
        }
        else{
            return _dataArray.count;
        }
        
    }
    else
    {
    return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *projectIntroCellID = @"projectIntroCellID";
    static NSString *projectRecordCellID = @"projectRecordCellID";
    
    UITableViewCell *projectIntroCell = [tableView dequeueReusableCellWithIdentifier:projectIntroCellID];
    InvestorRecordTableViewCell *projectRecordCell = (InvestorRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:projectRecordCellID];
    if (!_isIntroAndRecord ) {
        if (projectIntroCell == nil) {
            projectIntroCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:projectIntroCellID];
        }
            projectIntroCell.textLabel.text = [NSString stringWithFormat:@"       %@",_info.desc];
            projectIntroCell.textLabel.font = FONT16;
            projectIntroCell.textLabel.numberOfLines = 0;
        _emptyView.hidden = NO;
            return projectIntroCell;
    }
    else 
    {
        if (projectRecordCell == nil) {
            projectRecordCell = [[[NSBundle mainBundle] loadNibNamed:@"InvestorRecordTableViewCell" owner:self options:nil] lastObject];
        }
        if(indexPath.section == 0)
        {
            investorRecordModel *model = [[investorRecordModel alloc] init];
            model.type = @"-1";
            [projectRecordCell cellFillWithInvestorRecordModel:model];
            return projectRecordCell;
            
        }
        else
        {
            investorRecordModel *model = [[investorRecordModel alloc] init];
            model = _dataArray[indexPath.row];
            _emptyView.hidden = YES;
            [projectRecordCell cellFillWithInvestorRecordModel:model];
        return projectRecordCell;
        }
    }
        
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isIntroAndRecord) {
        return [InvestorRecordTableViewCell cellHeight];
    }else
    {
        return [GHStringManger stringBoundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 1000) font:FONT16 text:[NSString stringWithFormat:@"        %@",_info.desc]].height+ 20;
    }
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    
//    float ox = scrollView.contentOffset.x / iphone.width;
//    
//    [self.headerButtonView currentSelectButton:(int)ox];
//    
//}


#pragma mark -- headerButtonDelegate
- (void)headerButtonClick:(NSUInteger)index
{
    _isIntroAndRecord = index;
    [self.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    
    if (!_isIntroAndRecord) {
        
        [_projectIntroTableView reloadData];
        _projectRecordTableView.hidden = YES;
        _projectIntroTableView.hidden = NO;
    }
    else
    {
        [_projectRecordTableView reloadData];
        _projectIntroTableView.hidden = YES;
        _projectRecordTableView.hidden = NO;
    }
    
}
#pragma mark --
#pragma mark -- event response
- (void)requestData
{
    [[LMModelManage shareLLModelManage] getHuiRecordWithCategoryId:_info.huiId successBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            self.dataArray = [dataArray mutableCopy];
            [self isHavingMess];
            [_projectRecordTableView reloadData];
            [_projectIntroTableView reloadData];
        }
    } failureBlock:^(BOOL state) {
        
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
       
        _emptyView = [[EmptyCarView alloc] initWithFrame:CGRectMake(0, emptyViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        
    }
    [_projectRecordTableView addSubview:_emptyView];
}
- (void)addHuiView
{
    [self.view addSubview:self.huiView];
    _huiView.rateLabel.text = [NSString stringWithFormat:@"%@",_info.huiRate];
    _huiView.paymentMethodLabel.text =_info.incomeMethod;
    _huiView.timeLimitLabel.text = [NSString stringWithFormat:@"%@个月",_info.huiLimit];
    _huiView.beginAmountLabel.text = [NSString stringWithFormat:@"%@",_info.huiMoney];
    _huiView.icreaseMethodLabel.text = _info.increaseMethod;

}

#pragma mark --
#pragma mark -- setter and getter

- (HuiProjectIntroduceView *)huiView
{
    if (_huiView == nil) {
        
        _huiView = [[[NSBundle mainBundle] loadNibNamed:@"HuiProjectIntroduceView" owner:self options:nil] lastObject];
        _huiView.frame =CGRectMake(kGap, 74, SCREEN_WIDTH - 2*kGap, 180);
    }
    _huiView.backgroundColor = GLOBAL_GrayColor;
    return _huiView;
}

- (HeaderButtonView *)headerButtonView
{
    if (_headerButtonView  == nil) {
        
        _headerButtonView = [[HeaderButtonView alloc] initWithFrame:CGRectMake(0, 264, [UIScreen mainScreen].bounds.size.width, 44) titleArray:@[@"产品简介",@"投资记录"] imageArray:nil];
        
        _headerButtonView.delegate = self;
    }
    
    return _headerButtonView;
}

//- (UIScrollView *)scrollView
//{
//    if (_scrollView == nil) {
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, SCREEN_HEIGHT- 354)];
//        _scrollView.delegate = self;
//        _scrollView.pagingEnabled = YES;
//        _scrollView.tag = 100;
//        
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.bounces = NO;
//        
//        _scrollView.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
//    }
//    return _scrollView;
//}

- (UITableView *)projectIntroTableView
{
    if (_projectIntroTableView == nil) {
        _projectIntroTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, SCREEN_HEIGHT- 354)];
        _projectIntroTableView.delegate = self;
        _projectIntroTableView.dataSource = self;
        _projectIntroTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _projectIntroTableView;
}

- (UITableView *)projectRecordTableView
{
    if (_projectRecordTableView == nil) {
        _projectRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, SCREEN_HEIGHT- 354)];
        _projectRecordTableView.delegate = self;
        _projectRecordTableView.dataSource = self;
        _projectRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _projectRecordTableView;
}

- (HuiListModel *)model
{
    if (_model == nil) {
        _model = [[HuiListModel alloc] init];
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
