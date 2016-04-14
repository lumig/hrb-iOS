//
//  OrderViewController.m
//  hrb-iOS
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "OrderViewController.h"
#import "RecipentAddressTableViewCell.h"
#import "OrderGoodsMessTableViewCell.h"
#import "GoodsMessTableViewCell.h"
#import "MyOrderMessTableViewCell.h"
#import "AddressModel.h"
#import "SendGoodsTableViewCell.h"

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)AddressModel *addressModel;
@property(nonatomic,strong)NSString *expressTime;
@property(nonatomic,strong)NSString *expressName;

@end

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.addressModel = [[UserInfo shareUserInfo] getLocationAddressModel];
    self.goodsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"buyArray"];
    
    self.allPrice = [[NSUserDefaults standardUserDefaults] objectForKey:@"allPrice"];
    _expressName = [[UserInfo shareUserInfo] getExpressName];
    _expressTime = [[UserInfo shareUserInfo] getSendGoodsTime];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self.view addSubview:self.tableView];
    
    [self addBottomView];
}


#pragma mark --
#pragma mark -- delegate district

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return _goodsArray.count;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addressCellID = @"addressCellID";
    RecipentAddressTableViewCell *addressCell = (RecipentAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:addressCellID];
    static NSString *sendGoodsCellID = @"sendGoodsCellID";
    SendGoodsTableViewCell *sendGoodsCell = (SendGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:sendGoodsCellID];
    static NSString *goodsCellID = @"goodsCellID";
    OrderGoodsMessTableViewCell *goodsCell = (OrderGoodsMessTableViewCell *)[tableView dequeueReusableCellWithIdentifier:goodsCellID];
    static NSString *goodsMessCellID = @"goodsMessCellID";
    GoodsMessTableViewCell *goodsMessCell = (GoodsMessTableViewCell *)[tableView dequeueReusableCellWithIdentifier:goodsMessCellID];
    static NSString *orderCellID = @"orderCellID";
    MyOrderMessTableViewCell *orderCell =(MyOrderMessTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderCellID];
//    tableView.userInteractionEnabled = NO;
    if (indexPath.section == 0) {
        if (addressCell == nil) {
            addressCell = [[[NSBundle mainBundle] loadNibNamed:@"RecipentAddressTableViewCell" owner:self options:nil] lastObject];
        }
        addressCell.rightImgView.hidden = YES;
        [addressCell cellFillWithAddressModel:_addressModel];
        addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return addressCell;
    }else if (indexPath.section ==1)
    {
        if (sendGoodsCell == nil) {
            sendGoodsCell = [[[NSBundle mainBundle] loadNibNamed:@"SendGoodsTableViewCell" owner:self options:nil] lastObject];
        }
        sendGoodsCell.rightImgView.hidden = YES;
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
        sendGoodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return sendGoodsCell;
    }
    else if (indexPath.section == 2)
    {
        if (goodsCell == nil) {
            goodsCell = [[[NSBundle mainBundle] loadNibNamed:@"OrderGoodsMessTableViewCell" owner:self options:nil] lastObject];
        }
        NSDictionary *dic = _goodsArray[indexPath.row];
        [goodsCell cellFillWithGoodsWithDict:dic];
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return goodsCell;
    }else if (indexPath.section == 3)
    {
        if (goodsMessCell == nil) {
            goodsMessCell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsMessTableViewCell" owner:self options:nil] lastObject];
        }
        goodsMessCell.huiPriceLabel.text = _allPrice;
        goodsMessCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return goodsMessCell;
    }
    else
    {
        if (orderCell == nil) {
            orderCell = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderMessTableViewCell" owner:self options:nil] lastObject];
        }
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_logisticsId ==nil || [_logisticsId isEqualToString: @""]) {
            orderCell.orderNumLabel.text = _orderId;
            orderCell.logisticsLabel.hidden = YES;
            orderCell.logisticsNumLabel.hidden = YES;
        }
        else
        {
            orderCell.orderNumLabel.text = _orderId;
            orderCell.logisticsNumLabel.text = _logisticsId;
        }
        return orderCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [RecipentAddressTableViewCell cellHeight];
    }else if (indexPath.section == 1)
    {
        return [SendGoodsTableViewCell cellHeight];
    }
    else if (indexPath.section == 2)
    {
        return [OrderGoodsMessTableViewCell cellHeight];
    }else if (indexPath.section ==3)
    {
        return [GoodsMessTableViewCell cellHeight];
    }
    else
    {
        return [MyOrderMessTableViewCell cellHeight];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark --
#pragma mark -- response district
- (UIView *)addHeader
{
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    header.backgroundColor = [UIColor colorWithRed:71/255.0f green:83/255.0f blue:109/255.0f alpha:1];
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(10, 13, 200, 14)];
    label.text = @"交易成功";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [header addSubview:label];
    return header;
}

- (void)addBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
//    bottomView.backgroundColor = [UIColor colorWithRed:71/255.0f green:83/255.0f blue:109/255.0f alpha:1];
    bottomView.backgroundColor = [UIColor grayColor];
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2.0f, 17, 200, 15)];
    label.text = _typeStr;
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [bottomView addSubview:label];
    [self.view addSubview:bottomView];
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
        _tableView.tableHeaderView = [self addHeader];
    }
    return _tableView;
}

- (AddressModel *)addressModel
{
    if (_addressModel == nil) {
        _addressModel = [[AddressModel alloc] init];
    }
    return _addressModel;
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
