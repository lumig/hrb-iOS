//
//  SignInViewController.m
//  GuoHongHui
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInModel.h"
#import "SignInHeaderTableViewCell.h"
#import "SignInListTableViewCell.h"
#import "LMModelManage.h"


@interface SignInViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *signInArray;
@property(nonatomic,assign)BOOL isSignIn;
@property(nonatomic,strong)NSNumber *huiCode;

@property(nonatomic,strong)SignInModel *info;
@end

@implementation SignInViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"签到有礼";
    
    [self.view addSubview:self.tableView];
}

#pragma mark --
#pragma mark -- delegate district

#pragma mark -- uitableview delegate
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
        return 1;
    }
    else
    return _signInArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellHeader = @"cellHeader";
    static NSString *cellList = @"cellList";
    
    SignInHeaderTableViewCell *headerCell = (SignInHeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellHeader];
    SignInListTableViewCell *listCell = (SignInListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellList];
    if (indexPath.section == 0) {
        
        if (headerCell == nil) {
            
            headerCell = [[[NSBundle mainBundle] loadNibNamed:@"SignInHeaderTableViewCell" owner:self options:nil] lastObject];
        }
        [headerCell cellFillWithHuiCode:_huiCode ];
        [headerCell idDoSignIn:_isSignIn];
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }
    
    else if(indexPath.section == 1)
    {
        if (listCell == nil) {
            
            listCell = [[[NSBundle mainBundle] loadNibNamed:@"SignInListTableViewCell" owner:self options:nil] lastObject];
        }
        SignInModel *info = [[SignInModel alloc] init];
        info.type = @"-1";
        [listCell cellFillWithSignInModel:info];
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return listCell;
    }else
    {
        if (listCell == nil) {
            
            listCell = [[[NSBundle mainBundle] loadNibNamed:@"SignInListTableViewCell" owner:self options:nil] lastObject];
        }
        if (indexPath.row < _signInArray.count) {
            [listCell cellFillWithSignInModel:_signInArray[indexPath.row]];
        }
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return listCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 85;
    }
    else
        return [SignInListTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.1;
    }
    else
        
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark --
#pragma mark -- response event

- (void)requestData
{
    [[LMModelManage shareLLModelManage] getSignInDataWithView:self.view userId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] successfulBlock:^(BOOL state, NSMutableDictionary *dataDict) {
        if (state) {
            self.dataDict = [dataDict mutableCopy];
            
            if (_dataDict != nil) {
                
//                [self removeNetWorkErrorView];
                self.signInArray = [_dataDict objectForKey:@"signIn"];
                if ([_dataDict objectForKey:@"isSignIn"]) {
                    self.isSignIn = YES;
                }else
                {
                    self.isSignIn = NO;
                }
                self.huiCode = [_dataDict objectForKey:@"huiCode"];
                [[NSUserDefaults standardUserDefaults] setObject:_huiCode forKey:@"huiCode"];
                [_tableView reloadData];
            }
        }
    } failureBlock:^(BOOL state) {
        if (state) {
//            [self showNetWorkErrorView:nil];
        }
    }];
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

- (NSMutableDictionary *)dataDict
{
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (NSArray *)signInArray
{
    if (_signInArray == nil) {
        _signInArray = [NSArray array];
    }
    return _signInArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
