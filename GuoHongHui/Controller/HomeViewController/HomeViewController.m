//
//  HomeViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "HomeViewController.h"
#import "RegisterViewController.h"
#import "EScrollerView.h"
#import "MJRefresh.h"
#import "ATLabel.h"
#import "ActivityTableViewCell.h"
#import "ActivityModel.h"
#import "ProjectViewController.h"
#import "HuiRongBaoViewController.h"
#import "APService.h"
#import "HuiGoodsShowTableViewCell.h"
#import "goodsDetailInfo.h"
#import "GoodsDetailsViewController.h"
#import "homeGoodsCell.h"
#import "LastestNewsTableViewCell.h"
#import "LastestNewsModel.h"
#import "HuiWorldViewController.h"
#import "NewsViewController.h"
#import "HuiGoodsCell.h"

#import "HomeModel.h"
#import "NewsWebViewController.h"

#define eScrollHeight  ([UIScreen mainScreen].bounds.size.width == 320 ? 170:200)

@interface HomeViewController ()<EScrollerViewDelegate>

@property(nonatomic,strong)NSDictionary *homeDict;
@property(nonatomic,strong)HomeModel *model;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)EScrollerView *eScrollerView;
@property(nonatomic,strong)ATLabel *atLabel;

@property(nonatomic,strong)ActivityModel *activityModel;

@property(nonatomic,strong)NSMutableArray *addsArray;
@property(nonatomic,strong)NSArray *imageArray;

@property(nonatomic,strong)goodsDetailInfo *goodsInfo;

@property(nonatomic,strong)NSMutableArray *huiGoodsArray;

@property(nonatomic,strong)LastestNewsModel *newsModel;

@property(nonatomic,strong)NSMutableArray *newsArray;

@property(nonatomic,strong)NSArray *messArray;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self addRightBtn];
    
    [self.view addSubview:self.tableView];
    
//    NSLog(@"sanBox%@",NSHomeDirectory());
//     [APService setTags:[NSSet setWithObjects:@"polly901012",nil] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
//    
    
}


#pragma mark --
#pragma mark -- delegate district


#pragma mark --
#pragma mark -- UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if(section == 1)
    {
        return [_newsArray count];
    }
    else
    {
//        return [_huiGoodsArray count] / 2 + [_huiGoodsArray count] % 2;
        return [_huiGoodsArray count]/3 + ([_huiGoodsArray count]%3 > 0 ? 1:0);
    }
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *activityCellID = @"activityCellID";
    ActivityTableViewCell *cell = (ActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:activityCellID];
    
    static NSString *lastestNewsCellID = @"lastestNewsCellID";
    LastestNewsTableViewCell *lastestNewsCell = (LastestNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:lastestNewsCellID];
    
//    static NSString *goodsDescShowCellID = @"goodsDescShowCellID";
//    HuiGoodsShowTableViewCell *cellHui = (HuiGoodsShowTableViewCell *)[tableView dequeueReusableCellWithIdentifier:goodsDescShowCellID];
    
//    static NSString *huiGoodsCellID = @"huiGoodsCellID";
//    homeGoodsCell *huiGoodsCell = (homeGoodsCell *)[tableView dequeueReusableCellWithIdentifier:huiGoodsCellID];
    
    static NSString *goodsCellID = @"goodsCellID";
    HuiGoodsCell *goodsCell = (HuiGoodsCell *)[tableView dequeueReusableCellWithIdentifier:goodsCellID];
    
    if (indexPath.section == 0) {
        
        if (cell == nil) {
            
            cell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityCellID];
        }
        
//        cell.showLabel.text = @"最近一周";
//        [cell.atLabel animateWithWords:_imageArray forDuration:2.0];
        if (_homeDict == nil) {
            cell.hidden= YES;
        }
        else
        {
        [cell.leftImgView setImage:[UIImage imageNamed:@"APP_首页_02"]];
        [cell.rightImgView setImage:[UIImage imageNamed:@"APP_首页_031"]];
        }
        return cell;
    }
    else if(indexPath.section == 1)
    {
        if (lastestNewsCell == nil) {
            
            lastestNewsCell = [[LastestNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastestNewsCellID];
        }
        
        [lastestNewsCell cellFillWithLastestNewsModel:_newsArray[indexPath.row]];
        lastestNewsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return lastestNewsCell;
    }else
    {
//        if (huiGoodsCell == nil) {
//            
//            huiGoodsCell = [[homeGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:huiGoodsCellID];
//        }
//        
//        if ([_huiGoodsArray count]>indexPath.row *2) {
//            
//             BOOL rightFlag = [_huiGoodsArray count] > indexPath.row * 2 + 1;
//            [huiGoodsCell cellFillLeftModel:[_huiGoodsArray objectAtIndex:indexPath.row*2] leftRow:indexPath.row*2 rightModel:rightFlag ? [_huiGoodsArray objectAtIndex:indexPath.row*2 + 1]:nil rightRow:indexPath.row*2 + 1];
//        }
//        
//        huiGoodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return huiGoodsCell;
        
        
        if (goodsCell == nil) {
            goodsCell = [[HuiGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
        }
        if ([_huiGoodsArray count]>indexPath.row *3) {
            BOOL middleFlag = [_huiGoodsArray count] > indexPath.row * 3 + 1;
             BOOL rightFlag = [_huiGoodsArray count] > indexPath.row * 3 + 2;
            [goodsCell cellFillLeftModel:[_huiGoodsArray objectAtIndex:indexPath.row*3] leftRow:indexPath.row*3 andMiddleModel:middleFlag ? [_huiGoodsArray objectAtIndex:indexPath.row*3 + 1]:nil middletRow:indexPath.row*3 + 1 andRightModel:rightFlag ? [_huiGoodsArray objectAtIndex:indexPath.row*3 + 2]:nil rightRow:indexPath.row*3 + 2];
        }
  
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return goodsCell;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  SCREEN_WIDTH, 30)];
     UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kGap, 13, 80, 18)];
    if (_homeDict == nil) {
        header.hidden = YES;
    }
    else
    {
    [header addSubview:leftImgView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kGap- 42, 11, 30, 20)];
    [titleLabel setFont:FONT14];
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel setText:@"更多"];
    header.backgroundColor = [UIColor whiteColor];
    [header addSubview:titleLabel];
    
    UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-kGap - 12, 11, 12, 20)];
    [rightImgView setImage:[UIImage imageNamed:@"i_arrow_gray_right.png"]];
    [header addSubview:rightImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)];
    header.tag = section;
    [header addGestureRecognizer:tap];
    }
    if (section == 0) {
        return nil;
    }
    else if (section == 1)
    {
        [leftImgView setImage:[UIImage imageNamed:@"APP_首页_05.png"]];
    return header;
    }
    else
    {
        [leftImgView setImage:[UIImage imageNamed:@"APP_首页_09.png"]];
        return header;
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
//        return (eScrollHeight);
        return 0;
    }
    else
    {
        return 44;
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return [ActivityTableViewCell cellHeightForModel:_activityModel];
    }
    
    else if(indexPath.section == 1)
    {
        return [LastestNewsTableViewCell cellHeight];
    }
    else
    {
//        return [homeGoodsCell cellHeight];
        return [HuiGoodsCell cellHeight];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        LastestNewsModel *model = [[LastestNewsModel alloc] init];
        model = _newsArray[indexPath.row];
        NewsWebViewController *webVC = [[NewsWebViewController alloc] init];
        webVC.webTitle = model.newsName;
        webVC.webUrl = model.newsUrl;

        [self.navigationController pushViewController:webVC animated:YES];
    }
    
    
}

#pragma mark --
#pragma mark -- EScrollerViewDelegate
- (void)EScrollerViewDidClicked:(NSUInteger)index
{
    NewsWebViewController *webVC = [[NewsWebViewController alloc] init];
    webVC.webUrl = [_imageArray[index-1]objectForKey:@"url"];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark --
#pragma mark -- ScrollView delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = -64; //section的高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}



#pragma mark --
#pragma mark -- event response

- (void)registerBtnClick
{
    RegisterViewController *rigsterVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:rigsterVC animated:YES];
}




- (void)projectHeaderRefreash

{
    
}

- (void)projectFooterRefresh
{
    
}

- (void)headerTap:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 1) {
        
        NewsViewController *newsVC = [[NewsViewController alloc] init];
        [self.navigationController pushViewController:newsVC animated:YES];
    }
    else if (tap.view.tag == 2)
    {
        HuiWorldViewController *huiWorldVC = [[HuiWorldViewController alloc] init];
        [self.navigationController pushViewController:huiWorldVC animated:YES];
    }
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

//添加头部
- (UIView *)addHeaderView
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, eScrollHeight +30)];
    
    [header addSubview:self.eScrollerView];
    
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.eScrollerView.frame) , self.view.frame.size.width, 10)];
    [backImgView setImage:[UIImage imageNamed:@"background.png"]];
    [header addSubview:backImgView];
    
    
    //    //滚动label
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backImgView.frame) -10 , 80, 30)];
        showLabel.text = @"最近一周";
        [showLabel setFont:FONT15];
        showLabel.textColor = [UIColor grayColor];
        [header addSubview:showLabel];
    
        _atLabel = [[ATLabel alloc] initWithFrame:CGRectMake(85, CGRectGetMaxY(backImgView.frame)-10, 250, 30)];
        [_atLabel setFont:FONT13];
        [_atLabel animateWithWords:_messArray forDuration:2.0];
        [header addSubview:_atLabel];
    
    return header;

}


#pragma mark --
#pragma mark -- 路有消息
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    
    if ([eventName isEqualToString:GHActivtity_ROUTEREVENT]) {
        
        NSNumber *number = [userInfo objectForKey:@"index"];
        //        NSInteger row = [[userInfo objectForKey:@"row"] integerValue];
        if ([number integerValue] == 0) {
            
            [self gotoProjectVC];
        }
        else
        {
            [self gotoHuiRongBaoVC];
        }
    }
    else if ([eventName isEqualToString:GHHOMEGOODS_ROUTEREVENT]) {
        
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

#pragma mark --
#pragma mark -- 去往项目中心
- (void)gotoProjectVC
{
    ProjectViewController *projectVC = [[ProjectViewController alloc] init];
    [self.navigationController pushViewController:projectVC animated:YES];
}

#pragma mark --
#pragma mark -- 惠融宝
- (void)gotoHuiRongBaoVC
{
//    HuiRongBaoViewController *huirongbaoVC = [[HuiRongBaoViewController alloc] init];
//    [self.navigationController pushViewController:huirongbaoVC animated:YES];
    self.tabBarController.selectedIndex = 1;
}

#pragma mark --
#pragma mark -- 添加右边按钮
- (void)addRightBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitle:@"注册" forState:UIControlStateSelected];
    
    [rightBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //    rightBtn.titleLabel.textColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT15, NSFontAttributeName, RGBACOLOR(215, 29, 21, 1), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}

- (void)requestData
{
    [self.model getDataWithView:self.view successBlock:^(BOOL state, NSMutableDictionary *dataDict) {
        if (state) {
            self.homeDict = [dataDict mutableCopy];
            
            self.imageArray = _homeDict[@"addsUrl"];
            for (int i = 0; i < _imageArray.count; i++) {
                NSDictionary *dict= [NSDictionary dictionary];
                dict = _imageArray[i];
                [self.addsArray addObject:dict[@"imageUrl"]];
            }
            
            self.messArray = _homeDict[@"text"];
            self.newsArray = _homeDict[@"news"];
            self.huiGoodsArray = _homeDict[@"goods"];
            
            _tableView.tableHeaderView = [self addHeaderView];
            [_tableView reloadData];
        }
        
        if (_homeDict !=nil) {
            
            [self removeNetWorkErrorView];
            
        }
        
    } failureBlock:^(BOOL state) {
        if (state) {
            
            [self showNetWorkErrorView:nil];
        }
    }];
}


#pragma mark --
#pragma mark -- 网络错误重新加载数据
- (void)loadNetWorkData
{
    [self requestData];
}

#pragma mark --
#pragma mark --getter and setter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,self.view.bounds.size.height) style:UITableViewStyleGrouped ];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    //下拉刷新
//    __weak typeof(self) weakSelf = self;
//    
//    [_tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakSelf projectHeaderRefreash];
//    }];
//    
//    
//    [_tableView.header beginRefreshing];
   
    //另一种写法————学习
//    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(projectHeaderRefreash)];
////
////    
//    [_tableView addLegendFooterWithRefreshingBlock:^{
//        [weakSelf projectFooterRefresh];
//    }];
    
    return _tableView;
}

- (EScrollerView *)eScrollerView
{
    if (_eScrollerView == nil) {
        _eScrollerView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, self.view.frame.size.width, eScrollHeight) ImageArray:_addsArray TitleArray:nil autoPlay:YES];
        
        
        _eScrollerView.delegate = self;
    }
    
    return _eScrollerView;
}

- (NSMutableArray *)huiGoodsArray
{
    if (_huiGoodsArray == nil) {
        _huiGoodsArray = [[NSMutableArray alloc] init];
    }
    return _huiGoodsArray;

}

- (NSMutableArray *)newsArray
{
    if (_newsArray == nil) {
        _newsArray = [[NSMutableArray alloc] init];
    }
    
    return _newsArray;
}

- (HomeModel *)model
{
    if (_model ==nil) {
        _model = [[HomeModel alloc] init];
    }
    return _model;
}

- (NSDictionary *)homeDict
{
    if (_homeDict == nil) {
        _homeDict = [NSDictionary dictionary];
    }
    return _homeDict;
}

- (NSMutableArray *)addsArray
{
    if (_addsArray == nil) {
        _addsArray = [NSMutableArray array];
    }
    return _addsArray;
}

- (NSArray *)messArray
{
    if (_messArray == nil) {
        _messArray = [NSArray array];
    }
    return _messArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
