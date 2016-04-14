//
//  GoodsDetailsViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "GoodsDetailTableViewCell.h"
#import "BuyRecordsViewController.h"
#import "ShopCarViewController.h"
#import "DescPicTableViewCell.h"
#import "GoodsDetailModel.h"

@interface GoodsDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,GoodsDetailTableViewCellDelegate>

@property(nonatomic,strong)GoodsDetailModel *goodsDetailModel;
@property(nonatomic,strong)goodsDetailInfo *goodsInfo;
@property(nonatomic,strong)NSArray *descPicArray;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation GoodsDetailsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品介绍";

    self.isAddShopCar = YES;
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"goodsArray"];
}

#pragma mark --
#pragma mark -- delegate district

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
        return _descPicArray.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    static NSString *descPicCellID = @"descPicCellID";
    GoodsDetailTableViewCell *cell = (GoodsDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    DescPicTableViewCell *descPicCell = (DescPicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:descPicCellID];
    if (indexPath.section ==0) {
        if (cell == nil) {
            
            cell = [[GoodsDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        cell.delegate = self;
        if (_goodsInfo != nil) {
            [cell fillWithGoodsDetailInfo:_goodsInfo];
        }
        
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        return cell;

    }
    else
    {
        if (descPicCell == nil) {
            
            descPicCell = [[DescPicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:descPicCellID];
        }
        if (_descPicArray.count > 0) {
            [descPicCell cellFillDescPictDict:_descPicArray[indexPath.row]];
            descPicCell.selectionStyle =  UITableViewCellSelectionStyleNone;
        }
        
        
        return descPicCell;
    }
    }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [GoodsDetailTableViewCell cellHeight];

    }
    else
    {
        return [DescPicTableViewCell cellHeight];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark -- GoodsDetailTableViewCellDelegate

- (void)goodsMessageViewClick
{
    NSLog(@"goodsMessageViewClick");
}

-(void)buyRecordViewClick
{
    BuyRecordsViewController  *buyAndChangeVC = [[BuyRecordsViewController alloc] init];
    buyAndChangeVC.goodsId = _goodsInfo.goodsID;
    [self.navigationController pushViewController:buyAndChangeVC animated:YES];
}
- (void)minusBtnAndAddBtnClick:(NSInteger)index
{
        switch (index) {
            case 10:
            {
                if ([self.goodsInfo.goodsNum intValue] < 2) {
    
                }else
                {
                    int num = [_goodsInfo.goodsNum intValue];
                    num --;
    
                    [_goodsInfo setValue:[NSString stringWithFormat:@"%d",num] forKey:@"goodsNum"];
                }
                break;
            }
    
            case 11:
            {
                int num = [_goodsInfo.goodsNum intValue];
                num ++;
    
                [_goodsInfo setValue:[NSString stringWithFormat:@"%d",num] forKey:@"goodsNum"];
                break;
            }
            default:
                break;
        }
    [self loadDataWithView:self.view];
}

#pragma mark --
#pragma mark -- event reponse

- (void)requestData
{
    
    [self.goodsDetailModel getGoodsDetailDataWithView:self.view andproductId:_goodsID GoodsDetailBlock:^(BOOL state, goodsDetailInfo *goodsInfo) {
        
        if (state) {
            
            self.goodsInfo = goodsInfo;
            
        }
        _goodsInfo.goodsNum = @1;
        self.descPicArray = _goodsInfo.descPicArray;
        [self.view addSubview:self.tableView];
        
        [self.huiAmountLabel setText:[NSString stringWithFormat:@"%@",_goodsInfo.huiPrice]];
        
    //        NSLog(@"goodsInfo%@",_goodsInfo);
    } failureBlock:^(BOOL state) {
    }];
}

//父类方法
//加入购物车
- (void)substractBtnClick
{
    self.substractBtn.enabled = NO;
    self.substractBtn.backgroundColor = [UIColor grayColor];
    //存储数据
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
//    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSDictionary *goodsDic = @{@"goodsID":_goodsInfo.goodsID ,@"imgStr": _goodsInfo.imgArray[0],@"goodsTitle":_goodsInfo.goodsTitle,@"huiPrice":_goodsInfo.huiPrice,@"goodsNum":_goodsInfo.goodsNum,@"isSelected":@YES};
    
    [[UserInfo shareUserInfo] saveGoodsDetailDic:goodsDic];

    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });

//    NSLog(@"goodsDic %@",[[UserInfo shareUserInfo] getGoodsAray]);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"buyArray"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"allPrice"];
}

- (void)cartBtnClick
{
    
    ShopCarViewController *shopCarVC = [[ShopCarViewController alloc] init];
   
    shopCarVC.goodsArray = [NSMutableArray arrayWithArray:[[UserInfo shareUserInfo] getGoodsAray]];
//    NSLog(@"magi %@,%@",shopCarVC.goodsArray,[shopCarVC.goodsArray class]);
    shopCarVC.isAddShopCar = _isAddShopCar;
    [self.navigationController pushViewController:shopCarVC animated:YES];
}

- (void)loadDataWithView:(UIView *)view
{
    BOOL showHud = view !=nil;
    if (showHud) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }

    [_tableView reloadData];
    
    if(showHud){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    }
    
}

#pragma mark --
#pragma mark -- setter and getter

- (GoodsDetailModel *)goodsDetailModel
{
    if (_goodsDetailModel == nil) {
        _goodsDetailModel = [[GoodsDetailModel alloc] init];
    }
    
    return _goodsDetailModel;
}

- (goodsDetailInfo *)goodsInfo
{
    if (_goodsInfo == nil) {
        _goodsInfo = [[goodsDetailInfo alloc] init];
    }
    
    return _goodsInfo;
}
- (NSArray *)descPicArray
{
    if (_descPicArray == nil) {
        _descPicArray = [NSArray array];
    }
    return _descPicArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 64- 49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
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
