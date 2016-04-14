//
//  SettingViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "SettingViewController.h"
#import "FeedBackViewController.h"
#import "ModifyPswViewController.h"
#import "IntroduceViewController.h"
#import "AppUpdateModel.h"
#import "LoginViewController.h"


@interface SettingViewController ()<UIActionSheetDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *sction1Arr;
@property(nonatomic,strong)NSArray *section2Arr;
@property(nonatomic,strong)AppUpdateModel *updateModel;
@property(nonatomic,strong)NSDictionary *updateDic;
@property(nonatomic,strong)NSString *oldAppID;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    _sction1Arr = @[@"意见反馈",@"账户安全",@"公司介绍"];
    _section2Arr = @[@"退出"];
    
    _updateModel = [[AppUpdateModel alloc] init];
    
    
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}



#pragma mark --
#pragma mark -- Delegate District

#pragma amrk --
#pragma mark -- UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _sction1Arr.count;
    }
    else
        return _section2Arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = _sction1Arr[indexPath.row];
    }
    
    else
    {
        cell.textLabel.text = _section2Arr[indexPath.row];
    }
    [cell.textLabel setFont:FONT15];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, self.view.bounds.size.width, 1)];
    [lineImgView setImage:[UIImage imageNamed:@"line_01.png"]];
    [cell.contentView addSubview:lineImgView];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
                [self.navigationController pushViewController:feedBackVC animated:YES];
                
            }
                break;
                
            case 1:
            {
                ModifyPswViewController *modifyVC = [[ModifyPswViewController alloc] init];
                
                [self.navigationController pushViewController:modifyVC animated:YES];
                
            }
                break;
                
            case 2:
            {
                IntroduceViewController *introVC = [[IntroduceViewController alloc] init] ;
                [self.navigationController pushViewController:introVC animated:YES];
                
                
            }
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
                
//            {
//                [_updateModel getUpdateMessageWithUpdateBlock:^(BOOL state, NSMutableDictionary *dataDic) {
//                    if (state) {
//                        
//                        _updateDic = [dataDic mutableCopy];
//                        //                        NSLog(@"lumig%@",_updateDic);
//                        
////                        [self updateWithDic:_updateDic];
//                    }
//                }];
//            }
//                break;
//            case 1:
                
            {
                [self clickQuit];
            }
                break;
                
            default:
                break;
        }
    }
    
}

#pragma mark --
#pragma mark -- UIActionSheet delegate 弹出选择按钮项

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self exitLogin];
    }
}

#pragma mark --
#pragma mark -- Event Response

- (void)clickQuit
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"退出你将收不到消息,您确认退出了吗?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"安全退出" otherButtonTitles:nil, nil];
    
    [sheet showInView:self.view];
}

- (void)exitLogin
{
    [self showHudInView:self.view hint:@"正在退出..."];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    [self hideHud];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"iAddress"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"idCard"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icon"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"goodsArray"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"addressModel"];
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
    
}

- (void)updateWithDic:(NSDictionary *)dic
{
    NSString *appID = [dic objectForKey:@"appid"];
    //    NSString *IdStr = [dic objectForKey:@"id"];
    //    NSString *urlStr = [dic objectForKey:@"httpaddr"];
    //    if (![appID isEqualToString:_oldAppID]) {
    //
    //    }
    
    NSString * appstoreUrlString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=%@",appID];
    
    NSURL * url = [NSURL URLWithString:appstoreUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"can not open");
    }  
    
}

#pragma mark --
#pragma mark -- setter and getter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor = RGBACOLOR(248, 248, 248, 1);
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
