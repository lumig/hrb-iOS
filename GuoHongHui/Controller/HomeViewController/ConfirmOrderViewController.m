//
//  ConfirmOrderViewController.m
//  GuoHongHui
//
//  Created by LuMig on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "RecipentAddressTableViewCell.h"
#import "SendGoodsTableViewCell.h"
#import "PayMethodsTableViewCell.h"
#import "AddNewAddressTableViewCell.h"
#import "AddressModel.h"
#import "GHStringManger.h"
#import "OrderGoodsMessTableViewCell.h"
#import "sendSelectViewController.h"
#import "NewAddressViewController.h"
#import "goodsCalculateTableViewCell.h"
#import <AFNetworking.h>
#import "NSDictionary+LifeExtension.h"
#import "HuiWorldViewController.h"
#import "HomeViewController.h"
#import "payVC.h"

@interface ConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)AddressModel *addModel;

@property(nonatomic,strong)NSString *expressTime;
@property(nonatomic,strong)NSString *expressName;
@property(nonatomic,strong)NSString *totalStr;
@end

@implementation ConfirmOrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    _addModel = [[AddressModel alloc] init];
    
    _addModel = [[UserInfo shareUserInfo] getLocationAddressModel];
    _expressName = [[UserInfo shareUserInfo] getExpressName];
    _expressTime = [[UserInfo shareUserInfo] getSendGoodsTime];
    self.goodsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"buyArray"];
  
    self.allPrice = [[NSUserDefaults standardUserDefaults] objectForKey:@"allPrice"];
    self.totalPayStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"huiCode"]];
    
    [_tableView reloadData];
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isLogin];
    self.title = @"换购订单";
    
    [self addLeftBtn];
    [self addRightBtn];
    
    [self setBottomView];
        
//    self.goodsArray = [[UserInfo shareUserInfo] getGoodsAray];
//    NSLog(@"magi %@",_goodsArray);
    
    [self.view addSubview:self.tableView];
    
    [self loadDataWithView:self.view];
}

#pragma mark --
#pragma mark -- delegate district

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return _goodsArray.count;
    }
    else
    {
    return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *consigneeCellID = @"consigneeCellID";
    static NSString *addNewCellID = @"addNewCellID";
    static NSString *sendGoodsCellID = @"sendGoodsCellID";
    static NSString *payMethodsCellID = @"payMethodsCellID";
    static NSString *orderGoodsCellID = @"orderGoodsCellID";
    static NSString *goodsCalculateCellID = @"goodsCalculateCellID";
    
    RecipentAddressTableViewCell *consigneeCell = (RecipentAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:consigneeCellID];
    AddNewAddressTableViewCell *addNewCell = (AddNewAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:addNewCellID];
    SendGoodsTableViewCell *sendGoodsCell = (SendGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:sendGoodsCellID];
    
    PayMethodsTableViewCell *payMethodCell = [tableView dequeueReusableCellWithIdentifier:payMethodsCellID];
    
    OrderGoodsMessTableViewCell *goodsCell = (OrderGoodsMessTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderGoodsCellID];
    
    goodsCalculateTableViewCell *goodsCalculateCell = (goodsCalculateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:goodsCalculateCellID];
    if (indexPath.section == 0) {
        if (_addModel.consignee == nil) {
            
            if (addNewCell == nil) {
               
                addNewCell = [[[NSBundle mainBundle] loadNibNamed:@"AddNewAddressTableViewCell" owner:self options:nil] lastObject];
            }
            return addNewCell;
        }
        else
        {
        if (consigneeCell == nil) {
            consigneeCell = [[[NSBundle mainBundle] loadNibNamed:@"RecipentAddressTableViewCell" owner:self options:nil] lastObject];
            
        }
         
        [consigneeCell cellFillWithAddressModel:_addModel];
        return consigneeCell;
        }
    }
    else if ( indexPath.section == 1)
    {
        if (sendGoodsCell == nil) {
            
            sendGoodsCell = [[[NSBundle mainBundle] loadNibNamed:@"SendGoodsTableViewCell" owner:self options:nil] lastObject];
        }
        
        
        if (_expressName ==nil || [_expressName isEqualToString:@""]) {
            
            sendGoodsCell.expressChooseLabel.text =@"系统匹配快递";
            _expressTime =  @"只工作日送货（双休日，假期不用送）";
            sendGoodsCell.sendTimeLabel.text = _expressTime;
        }
        else
        {
            sendGoodsCell.expressChooseLabel.text =_expressName;
            sendGoodsCell.sendTimeLabel.text = _expressTime;
        }
//        NSLog(@"expressnamelist %@",[[UserInfo shareUserInfo] getSendGoodsTime]);
        
        
        
        return sendGoodsCell;
    }
    else if(indexPath.section == 2)
    {
        if (payMethodCell == nil) {
            
            payMethodCell = [[[NSBundle mainBundle] loadNibNamed:@"PayMethodsTableViewCell" owner:self options:nil] lastObject];
        }

        payMethodCell.totalHuiCodeLabel.text = _totalPayStr;
        return payMethodCell;
    }
    
  else if(indexPath.section == 3)
  {
      if (goodsCell == nil) {
          
          goodsCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderGoodsMessTableViewCell" owner:self options:nil] lastObject];
      }
      
      NSDictionary *dic = _goodsArray[indexPath.row];
      [goodsCell cellFillWithGoodsWithDict:dic];
    
            return goodsCell;
  }
    
    else
        
    {
        if (goodsCalculateCell == nil) {
            
            goodsCalculateCell = [[[NSBundle mainBundle] loadNibNamed:@"goodsCalculateTableViewCell" owner:self options:nil] lastObject];
            goodsCalculateCell.totalHuiCodeLabel.text = _totalPayStr;
            goodsCalculateCell.totalPayLabel.text = _allPrice;
            _totalStr = [NSString stringWithFormat:@"%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"huiCode"] intValue]-[_allPrice intValue]];
            goodsCalculateCell.lastHuiCodeLabel.text = _totalStr;
        }
        
        return goodsCalculateCell;
    }
      
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3 || section == 4) {
        return 0;
    }
    else
    {
    return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_addModel.consignee == nil) {
            
            return [AddNewAddressTableViewCell cellHeight];
        }
        else
        
        return [RecipentAddressTableViewCell cellHeight];
    }
    else if(indexPath.section == 1)
    {
        return [SendGoodsTableViewCell cellHeight];
    }
    
    else if (indexPath.section == 2)
    {
        return [PayMethodsTableViewCell cellHeight];
    }
    else if (indexPath.section == 3)
    {
        return [OrderGoodsMessTableViewCell cellHeight];
    }
    else
    {
        return [goodsCalculateTableViewCell cellHeight];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
            NewAddressViewController *newAddressVC = [[NewAddressViewController alloc] init];
        [self.navigationController pushViewController:newAddressVC animated:YES];
//        NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:0 inSection:0];
//        NSArray *indexArray = [NSArray arrayWithObject:indexPath_1];
//          [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableView reloadData];
        
    }
   else if(indexPath.section == 1)
    {
        sendSelectViewController *sendSelectVC = [[sendSelectViewController alloc] init];
        [self.navigationController pushViewController:sendSelectVC animated:YES];
            }
//    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark --
#pragma mark -- response event
- (void)addLeftBtn
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22.5, 22)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"i_arrow_white_left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
}

- (void)addRightBtn
{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 22)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitle:@"首页" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)setBottomView
{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    bottomView.backgroundColor = TOPBACKGOUDCOLOR;
    [self.view addSubview:bottomView];
    
    
    UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    topImgView.backgroundColor = GLOBAL_GrayColor;
    [bottomView addSubview:topImgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13, [GHStringManger stringBoundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 24) font:FONT12 text:@"此单需要支付"].width, 24)];
    nameLabel.text = @"此单需要支付";
    nameLabel.font = FONT12;
    [bottomView addSubview:nameLabel];
    
    _huiAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, 13, 200, 24)];
    _huiAmountLabel.textColor = GLOBAL_RedColor;
    _huiAmountLabel.font = FONT16;
    _huiAmountLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"allPrice"];
    _huiAmountLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:_huiAmountLabel];
    
    _substractBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 10, 80, 30)];
    _substractBtn.backgroundColor = GLOBAL_RedColor;
    [_substractBtn.titleLabel setTextColor:[UIColor whiteColor]];
    
    [_substractBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    
    [_substractBtn.titleLabel setFont:FONT16];
    _substractBtn.layer.cornerRadius = 6;
    _substractBtn.layer.masksToBounds = YES;
    
    [_substractBtn addTarget:self action:@selector(substractBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_substractBtn];
    
       
   
}

- (void)substractBtnClick
{
    
    if ([_totalPayStr intValue] < [_allPrice intValue] ||_goodsArray == nil) {
        _substractBtn.enabled = NO;
        _substractBtn.backgroundColor = [UIColor grayColor];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"惠金币余额不足，请与国弘汇金融进行理财产品合作获得惠金币，或每日签到获得惠金币!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        if (_addModel == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写收货人地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[_totalPayStr intValue] - [_allPrice intValue]] forKey:@"huiCode"];
            [self updateGoodsMessWithUserId:[NSNumber numberWithInt:[[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] intValue]] consignee:_addModel.consignee mobile:_addModel.cellPhone detailAddress:_addModel.address orderWay:_expressTime orderlist:_goodsArray];
            
            payVC *pay= [[payVC alloc] init];
            [self.navigationController pushViewController:pay animated:YES];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"buyArray"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"goodsArray"];
            _goodsArray = nil;
            _allPrice = @"0";
        }
        
    }
    }

- (void)updateGoodsMessWithUserId:(NSNumber *)userId consignee:(NSString *)consignee mobile:(NSString *)mobile detailAddress:(NSString *)detailAddress orderWay:(NSString *)orderWay orderlist:(NSArray *)orderlist{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",nil];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary  *dict in orderlist ) {
        NSMutableDictionary *goodsDict = [NSMutableDictionary dictionary];
        [goodsDict setValue:[dict objectForKey:@"goodsID"] forKey:@"productId"];
        [goodsDict setValue:[dict objectForKey:@"goodsNum"] forKey:@"num"];
        [goodsDict setValue:[dict objectForKey:@"huiPrice"] forKey:@"price"];
        [dataArray addObject:goodsDict];
    }
   
    NSData *data= [NSJSONSerialization dataWithJSONObject:dataArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
   NSDictionary *para = @{@"userId":userId,@"consignee":consignee,@"mobile":mobile,@"detailAddress":detailAddress,@"orderWay":orderWay,@"orderlist":str};
    NSString *urlStr = urlStr(@"order/saveOrder");
    
    [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject%@",responseObject);
        NSDictionary *dict = [NSDictionary dictionary];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = [responseObject mutableCopy];
            _isSuccess = dict[@"result"];
        }
//        //设置动画
//        
//            [UIView animateWithDuration:6 animations:^{
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.mode = MBProgressHUDModeText;
//                if (_isSuccess) {
//                    hud.labelText = @"支付成功...";
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"goodsArray"];
//                }
//                else
//                {
//                    hud.labelText = @"余额不足...";
//                }
//                hud.margin = 40;
//                hud.yOffset = 30;
//
//            } completion:^(BOOL finished) {
//                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//            } ];


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
        
    }];
}


#pragma mark -- buttonClick

- (void)backClicked:(id)sender
{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClicked:(id)sender
{
//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    [self.navigationController pushViewController:homeVC animated:YES];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//刷新
- (void)loadDataWithView:(UIView *)view
{
    BOOL showHud = view !=nil;
    if (showHud) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    
    [self.tableView reloadData];
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    }
    
}



#pragma mark --
#pragma mark -- setter and getter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 49-64)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    
    return _tableView;
}

- (NSArray *)goodsArray
{
    if (_goodsArray == nil) {
        _goodsArray = [NSMutableArray array];
    }
    
    return _goodsArray;
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
