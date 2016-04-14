//
//  AddressListViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/3.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "AddressListViewController.h"

@interface AddressListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址";
    
    [self addLeftBtn];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark --
#pragma mark -- delegate district

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (indexPath.section == 0) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 120)/2.0f, 11, 120, 22)];
        [btn setImage:[UIImage imageNamed:@"i_add.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"i_add.png"] forState:UIControlStateSelected];
        btn.titleLabel.font = FONT15;
        [btn setTitle:@"  添加新地址" forState:UIControlStateNormal];
        [btn setTitle:@"  添加新地址" forState:UIControlStateSelected];
        
        [cell addSubview:btn];
    }
    else
    {
        
    }
    
    return cell;
}


#pragma mark --
#pragma mark -- response event
- (void)addLeftBtn
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22.5, 24)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"i_arrow_white_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
}

#pragma mark -- buttonClick

- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --
#pragma mark -- setter and getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
