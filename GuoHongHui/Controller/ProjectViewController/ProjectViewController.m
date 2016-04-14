//
//  ProjectViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectCenterModel.h"
#import "ProjectListInfo.h"
#import "ProjectListTableViewCell.h"
#import "MJRefresh.h"
#import "ProjectProgressViewController.h"
#import "ProjectListCell.h"
#import "UIResponder+Router.h"
#import "ProjectListModel.h"
@interface ProjectViewController ()

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ProjectListModel *model;
//不用了 
@property(nonatomic,strong)ProjectCenterModel *projectModel;
@property(nonatomic,strong)NSMutableArray *projectArray;
@property(nonatomic,strong)ProjectListInfo *info;

@end

@implementation ProjectViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"项目列表";
    [self.view addSubview:self.tableView];
}

#pragma mark --
#pragma mark -- Delegate District

#pragma mark --
#pragma mark -- UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_projectArray count]/2 +[_projectArray count]%2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ProjectListCell *cell = (ProjectListCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ProjectListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if ([_projectArray count]>indexPath.row *2) {
        
        BOOL rightFlag = [_projectArray count] > indexPath.row * 2 + 1;
        [cell cellFillLeftModel:[_projectArray objectAtIndex:indexPath.row*2] leftRow:indexPath.row*2 rightModel:rightFlag ? [_projectArray objectAtIndex:indexPath.row*2 + 1]:nil rightRow:indexPath.row*2 + 1];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ProjectListCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectListCell *cell = (ProjectListCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}


#pragma mark --
#pragma mark -- 路有消息
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    
     if ([eventName isEqualToString:GHPROJECTLIST_ROUTEREVENT]) {
        
        NSUInteger row = [[userInfo objectForKey:@"row"] integerValue];
        
        if ([_projectArray count] > row)
        {
            ProjectListInfo *info = [_projectArray objectAtIndex:row];
            
            ProjectProgressViewController *projectProgressVC = [[ProjectProgressViewController alloc] init];
            projectProgressVC.projectId =info.projectID;
            [self.navigationController pushViewController:projectProgressVC animated:YES];
        }
    }
    
    
    
}


#pragma mark --
#pragma mark -- Event Response


- (void)projectHeaderRefreash
{
    _projectModel = [[ProjectCenterModel alloc] init];
    
    [_projectModel getProjectDataWithView:self.view andProjectCenterBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            [self removeNetWorkErrorView];
            _projectArray = [dataArray mutableCopy];
            [_tableView reloadData];
        }
        [self.tableView.header endRefreshing];
        
    } andFailureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    }
     ];
}

- (void)projectFooterRefresh
{
    //更多信息
    
    [_projectModel getProjectDataWithView:self.view andProjectCenterBlock:^(BOOL state, NSMutableArray *dataArray) {
        if (state) {
            [self removeNetWorkErrorView];
            _projectArray = [dataArray mutableCopy];
            [_tableView reloadData];
            
        }
        
        [self.tableView.footer endRefreshing];
    }andFailureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];
        }
    }
     ];
    
}

- (void)requestData
{
    [self.model getProjectListDataWithView:self.view ProjectListBlock:^(BOOL state, NSMutableArray *dataArray) {
        
        if (state) {
            self.projectArray = [dataArray mutableCopy];
            
            [_tableView reloadData];
        }
    } failureBlock:^(BOOL state) {
        [self showNetWorkErrorView:nil];
    } ];
}

#pragma amrk --
#pragma mark -- setter and getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    //添加下拉刷新    
//    __weak typeof(self) weakSelf = self;
//    
//    [_tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakSelf projectHeaderRefreash];
//    }];
//    
//    
//    [_tableView.header beginRefreshing];
//    
//    //添加下拉刷新
//    [_tableView addLegendFooterWithRefreshingBlock:^{
//        [weakSelf projectFooterRefresh];
//    }];
    
  
    
    return _tableView;
}

- (ProjectListModel *)model
{
    if (_model == nil) {
        _model = [[ProjectListModel alloc] init];
    }
    return _model;
}

- (NSMutableArray *)projectArray
{
    if (_projectArray == nil) {
        
        _projectArray = [[NSMutableArray alloc] init];
    }
    return _projectArray;
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
