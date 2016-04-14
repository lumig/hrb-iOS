//
//  NewsViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "NewsViewController.h"
#import "LastestNewsTableViewCell.h"
#import "LastestNewsModel.h"
#import "NewsModel.h"
#import "NewsWebViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NewsModel *model;
@property(nonatomic,strong)LastestNewsModel *newsModel;

@property(nonatomic,strong)NSMutableArray *newsArray;
@end

@implementation NewsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"最新资讯";
    [self.view addSubview:self.tableView];
   
}

#pragma mark -- 
#pragma mark -- delegate district

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *lastestNewsCellID = @"lastestNewsCellID";
    LastestNewsTableViewCell *lastestNewsCell = (LastestNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:lastestNewsCellID];
    
    if (lastestNewsCell == nil) {
        
        lastestNewsCell = [[LastestNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastestNewsCellID];
    }
    
    [lastestNewsCell cellFillWithLastestNewsModel:_newsArray[indexPath.row]];
    lastestNewsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return lastestNewsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LastestNewsTableViewCell cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LastestNewsTableViewCell *cell = (LastestNewsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsWebViewController *newsVC = [[NewsWebViewController alloc] init];
    LastestNewsModel *model = [[LastestNewsModel alloc] init];
    model = _newsArray[indexPath.row];
    newsVC.webTitle = model.newsName;
    newsVC.webUrl = model.newsUrl;

    [self.navigationController pushViewController:newsVC animated:YES];
}

#pragma mark --
#pragma mark -- response event

- (void)requestData
{
    [self.model getNewsDataWithView:self.view NewsBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            self.newsArray = [dataArray mutableCopy];
            
            
            [_tableView reloadData];
        }
    } failureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    }];
}

#pragma mark --
#pragma mark-- setter and getter
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

- (NewsModel *)model
{
    if (_model == nil) {
        _model = [[NewsModel alloc] init];
    }
    
    return _model;
}

- (NSMutableArray *)newsArray
{
    if (_newsArray == nil) {
        _newsArray = [[NSMutableArray alloc] init];
    }
    
    return _newsArray;
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
