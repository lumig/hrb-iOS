//
//  ProjectProgressViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectProgressViewController.h"
#import "ProjectProgressTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ProjectProgressInfo.h"
#import "ProjectProgressingModel.h"
#import "MJRefresh.h"
#import "ProjectProgressModel.h"
#import "LMModelManage.h"

@interface ProjectProgressViewController ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ProjectProgressModel *model;
@property(nonatomic,strong)NSArray *projectArray;


//测试
@property(nonatomic,strong)ProjectProgressInfo *proInfo;
@end

@implementation ProjectProgressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"项目进展";
    [self.view addSubview:self.tableView];
}

#pragma mark --
#pragma mark -- Delegate District

#pragma mark --
#pragma mark -- UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _projectArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ProjectProgressTableViewCell *cell = (ProjectProgressTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    ProjectProgressTableViewCell *cell = (ProjectProgressTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ProjectProgressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row < _projectArray.count) {
        [cell fillCellWithProjectProgressInfo:_projectArray[indexPath.row]];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ProjectProgressTableViewCell getCellHeightWithProjectProgressInfo:_projectArray[indexPath.row]];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

#pragma mark --
#pragma mark -- ScrollView delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 10; //section的高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//
//}


#pragma mark --
#pragma mark -- Event Response

- (void)requestData
{
    [self.model getProjectProgressDataWithView:self.view andProjectId:_projectId ProjectProgressBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            self.projectArray = [dataArray mutableCopy];
            if (_projectArray !=nil) {

                [_tableView reloadData];
            }
            
        }
    } failureBlock:^(BOOL state) {
        [self showNetWorkErrorView:nil];
    }];
}


- (void)projectHeaderRefreash

{
    
}

- (void)projectFooterRefresh
{
    
}

#pragma mark --
#pragma mark -- setter and getter

- (ProjectProgressModel *)model
{
    if (_model == nil) {
        _model = [[ProjectProgressModel alloc] init];
    }
    return _model;
}

- (NSArray *)projectArray
{
    if (_projectArray == nil) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
//    __weak typeof(self) weakSelf = self;
//    
//    [_tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakSelf projectHeaderRefreash];
//    }];
//    
//    
//    [_tableView.header beginRefreshing];
//    
//    [_tableView addLegendFooterWithRefreshingBlock:^{
//        [weakSelf projectFooterRefresh];
//    }];
    
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
