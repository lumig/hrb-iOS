//
//  MyViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/5/5.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "MyViewController.h"
#import "UserInfo.h"
#import "UserMessageDataBase.h"
#import "MyBaoListTableViewCell.h"
#import "myBaoInfo.h"
#import "MyBtnListTableViewCell.h"
#import "BtnListView.h"
#import "ListButton.h"
#import "HuiOrderViewController.h"
#import "SignInViewController.h"
#import "holdingViewController.h"
#import "HaveEarnedViewController.h"
#import "ParticularRecommendViewController.h"
#import "CalendarHomeViewController.h"
#import "InvestmentStatisticsViewController.h"
#import "LoginViewController.h"
#import "NavViewController.h"
#import "InvestmentTableViewCell.h"
#import "WaitingViewController.h"
#import "LMModelManage.h"
#import <UIImageView+AFNetworking.h>


#define kHeaderHeight  120


@interface MyViewController ()<MyBtnListTableViewCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)myBaoInfo *myInfo1;
@property(nonatomic,strong)myBaoInfo *myInfo2;
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSDictionary *dataDict;
@property(nonatomic,strong)NSArray *infoArray;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UIImageView *logoImgView;
@property(nonatomic,strong)UIImage *logoImg;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NSString *userName;

@property(strong,nonatomic)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)LoginViewController *loginVC;

@property(nonatomic,strong)NSDictionary *calendarDict;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"username%@",[[NSUserDefaults standardUserDefaults
//                          ] objectForKey:@"idCard"] );

    [self isLogin];
    self.title = @"我的";
        
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark --
#pragma mark -- delegate district


#pragma mark --
#pragma mark -- UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID;
   
    
    if (indexPath.section == 0) {
        cellID = @"myCellID";
        
        MyBaoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            cell = (MyBaoListTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"MyBaoListTableViewCell" owner:self options:nil] lastObject];
        }
        if (_listArray == nil) {
            cell.hidden = YES;
        }
        else
        {
        [cell fillCellWithMyBaoInfo:_listArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        cellID = @"myBtnListCell";
        MyBtnListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[MyBtnListTableViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) andImageArray:self.imageArray andTitleArray:self.titleArray andStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
//            cell = [[MyBtnListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        [cell fetchWithMyBtnListTableViewCellWithImageArray:self.imageArray andTitleArray:self.titleArray];
        if (_listArray == nil) {
            cell.hidden = YES;
        }
     
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return kHeaderHeight;
//    }
//    else
//    {
    return 10;
//    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        
//        UIView *header = [self addHeaderView];
//        
//        return header;
//    }
//    
//    else
//    {
//        return nil;
//    }
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;

    }
    else
    {
        return [MyBtnListTableViewCell getCellHeight];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WaitingViewController *waitVC = [[WaitingViewController alloc] init];
//        waitVC.totalAmout = _myInfo2.moneyStr;
        [self.navigationController pushViewController:waitVC animated:YES];
    }
    
}

#pragma mark --  UIImagePickerController  delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *original_image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    _logoImg = original_image;
    
    self.logoImgView.image = _logoImg;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self modifyFace];
        
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark -- actionSheet delegate


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
        if (buttonIndex == 0)
        {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
        else if (buttonIndex == 1)
        {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
    
}


#pragma MARK -- Mycelldelegate

-(void)btnListClick:(NSInteger)index
{
    if (index == 1000) {
        HuiOrderViewController *orderVC = [[HuiOrderViewController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }
    else if (index == 1001) {
        //
        SignInViewController *signInVC = [[SignInViewController alloc] init];
        [self.navigationController pushViewController:signInVC animated:YES];
    }
    else if(index == 1002)
    {
        holdingViewController *holdingVC = [[holdingViewController alloc] init];
        [self.navigationController pushViewController:holdingVC animated:YES];
    }
    else if (index == 1003)
    {
        HaveEarnedViewController *haveEarnedVC = [[HaveEarnedViewController alloc] init];
        
        [self.navigationController pushViewController:haveEarnedVC animated:YES];
    }
    else if (index == 1004)
    {
        ParticularRecommendViewController *particularVC = [[ParticularRecommendViewController alloc] init];
        [self.navigationController pushViewController:particularVC animated:YES];
    }
    else if (index == 1005)
    {
        InvestmentStatisticsViewController *investmentVC = [[InvestmentStatisticsViewController alloc] init];
        [self.navigationController pushViewController:investmentVC animated:YES];
    }
    else if(index == 1006)
    {
        CalendarHomeViewController *calendarVC = [[CalendarHomeViewController alloc] init];
        
        calendarVC.calendartitle = @"收款日历";
        
        [[LMModelManage shareLLModelManage] getCalendarDataWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successfulBlock:^(BOOL state, NSMutableDictionary *dataDict) {
            if (state) {
                self.calendarDict = [dataDict mutableCopy];
                int day = [_calendarDict[@"intervalDate"] intValue];
                if (day != 0) {
                    
                    BOOL isEarning = [_calendarDict[@"incomeType"] boolValue];
                    NSArray *array = _calendarDict[@"listInterest"];
                    calendarVC.dataArray = array;
                    calendarVC.isEveryMonthEarning = isEarning;
                    
                    [calendarVC setAirPlaneToDay:day ToDateforString:nil];
                }
                else
                {
                     day = 1;
                    BOOL isEarning = NO;
                    calendarVC.dataArray = @[@"0"];
                    calendarVC.isEveryMonthEarning = isEarning;
                    
                    [calendarVC setAirPlaneToDay:day ToDateforString:nil];
                }
            }
            
        } failureBlock:^(BOOL state) {
            
        }];
        
      
        
        [self.navigationController pushViewController:calendarVC animated:YES];
    }
}

#pragma mark --
#pragma mark -- ScrollView delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = kHeaderHeight; //section的高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}



#pragma mark --
#pragma mark -- event response


- (void)imgClick:(UITapGestureRecognizer *)tap
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择相片源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    
    sheet.tag = 20;
    
    [sheet showInView:self.view];
}

//上传修改的图片
- (void)modifyFace
{
    [self showHudInView:self.view hint:@"正在修改..."];
    //_logoImg
    [[LMModelManage shareLLModelManage] upLoadWithUserFace:_logoImg idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] faceBlock:^(BOOL state, NSString *imageUrl)
     {
         [self hideHud];
         
         if (state)
         {
             if ([imageUrl isKindOfClass:[NSNull class]] ) {
                 [_logoImgView setImage:GHSMALLIMAGE];
                 [_tableView reloadData];
             }
             else
             {
             [_logoImgView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:GHSMALLIMAGE];
             [[NSUserDefaults standardUserDefaults] setObject:imageUrl forKey:@"icon"];
             [_tableView reloadData];
             }
         }
         
     }];
}

- (void)requestData
{
    [[LMModelManage shareLLModelManage] getMyEarningDataWithView:self.view idCard:[[NSUserDefaults standardUserDefaults] objectForKey:@"idCard"] successfulBlock:^(BOOL state, NSMutableDictionary *dataDict) {
        if (state) {
            self.dataDict = [dataDict mutableCopy];
            if (_dataDict != nil) {
                 [self removeNetWorkErrorView];
                _myInfo2 = [[myBaoInfo alloc] init];
                _myInfo2.imageStr = @"APP_我的_10.png";
                _myInfo2.nameStr = @"预期待收益";
                _myInfo2.moneyStr = [_dataDict objectForKey:@"amount"];
                [self.listArray addObject:_myInfo2];
                
                self.headerView = [self addHeaderView];
                _tableView.tableHeaderView = self.headerView;
                
                [_tableView reloadData];
            }
        }
        
    } failureBlock:^(BOOL state) {
        if (state) {
            [self showNetWorkErrorView:nil];

        }
    }];
}



#pragma mark --
#pragma mark -- getter and setter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    [_tableView reloadData];
    
    return _tableView;
}


- (UIView *)addHeaderView
{
    //headerView中加个背景
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kHeaderHeight)];
    UIImageView *backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kHeaderHeight)];
    
    backImgView.image = [UIImage imageNamed:@"APP_我的_02.png"];
    [header addSubview:backImgView];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 30, 60, 60)];
//    imgView.center = CGPointMake(self.view.bounds.size.width / 3.0f, 60);
    NSString *icon = [[NSUserDefaults standardUserDefaults] objectForKey:@"icon"];
   
    [imgView setUserInteractionEnabled:YES];
    imgView.layer.cornerRadius = 30;
    imgView.layer.masksToBounds = YES;
    imgView.layer.borderWidth = 2;
    imgView.layer.borderColor = [[UIColor whiteColor] CGColor];
    if (icon == nil) {
        [imgView setImage:[UIImage imageNamed:@"defaultIcon"]];
    }
    else
    {
        [imgView setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"defaultIcon"]];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
    
    [imgView addGestureRecognizer:tap];
    _logoImgView = imgView;
    [header addSubview:imgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, CGRectGetMinY(imgView.frame) + 5, 200, 25)];
    _userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    if (_userName == nil) {
        nameLabel.text = @"国弘汇金融";
    }else
    {
    nameLabel.text = _userName;
    }
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [nameLabel setFont:FONT16];
    [nameLabel setTextColor:[UIColor whiteColor]];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, CGRectGetMinY(imgView.frame) + 30, 200, 25)];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"iAddress"]) {
        addressLabel.text = @"上海 上海";
    }
    else
    {
        addressLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"iAddress"] ;
    }
//    NSLog(@"address%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"iAddress"]);
    
    addressLabel.textAlignment = NSTextAlignmentLeft;
    [addressLabel setFont:FONT16];
    [addressLabel setTextColor:[UIColor whiteColor]];
    
    [header addSubview:nameLabel];
    [header addSubview:addressLabel];
    return header;

}

- (NSArray *)imageArray
{

    if (_imageArray == nil) {
        _imageArray =@[@"APP_我的_14.png",@"APP_我的_00_03.png",@"APP_我的_18.png",@"APP_我的_20.png",@"APP_我的_27.png",@"APP_我的_33.png",@"APP_我的_30.png"];
    }
    return _imageArray;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"惠订单",@"签到有礼",@"收益中",@"已收益",@"特别推荐",@"投资统计",@"收款日历"];
    }
    return _titleArray;
}
- (UIImagePickerController *)imagePickerController
{
    if (_imagePickerController == nil)
    {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.delegate = self;
        
        _imagePickerController.allowsEditing = YES;
    }
    
    return _imagePickerController;
}

- (NSDictionary *)dataDict
{
    if (_dataDict == nil) {
        _dataDict = [NSDictionary dictionary];
    }
    
    return _dataDict;
}

- (NSDictionary *)calendarDict
{
    if (_calendarDict == nil) {
        _calendarDict = [NSDictionary dictionary];
    }
    return _calendarDict;
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
