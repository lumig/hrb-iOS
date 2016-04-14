//
//  ShopCarViewController.m
//  GuoHongHui
//
//  Created by mac on 15/7/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarGoodsTableViewCell.h"
#import "goodsDetailInfo.h"
#import "ShopCarFooterTableViewCell.h"
#import "GHStringManger.h"
#import "ConfirmOrderViewController.h"
#import <MBProgressHUD.h>
#import "GoodsDetailsViewController.h"

@interface ShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,ShopCarGoodsTableViewCellDelegate,ShopCarFooterTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ShopCarFooterTableViewCell *footer;

@property(nonatomic,assign)CGFloat allPrice;
@end

@implementation ShopCarViewController

- (void)viewWillAppear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购物车";
    
    [self.view addSubview:self.tableView];
    //刷新
    [self loadDataWithView:self.view];
    
    [self.view addSubview:self.footer];
    [self totalPrice];
}

#pragma mark --
#pragma mark -- delegate district

#pragma mark -- uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_goodsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ShopCarGoodsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (goodsCell == nil) {
        
        goodsCell = [[[NSBundle mainBundle] loadNibNamed:@"ShopCarGoodsTableViewCell" owner:self options:nil] lastObject];
    }
    
    goodsCell.delegate = self;
    NSDictionary *dic = _goodsArray[indexPath.row];
    goodsDetailInfo *info = [[goodsDetailInfo alloc] init];
//    NSLog(@"goodsTitle%@",[dic objectForKey:@"goodsTitle"]);
    info.goodsID = [dic objectForKey:@"goodsID"];
    info.goodsTitle = [dic objectForKey:@"goodsTitle"];
    info.goodsNum = [dic objectForKey:@"goodsNum"];
    info.imgStr = [dic objectForKey:@"imgStr"];
    info.isSelected = [[dic objectForKey:@"isSelected"] boolValue];
    info.huiPrice = [dic objectForKey:@"huiPrice"];
    [goodsCell cellFillWithgoodsDetailInfo:info];
    //选中样式
    goodsCell.tag = indexPath.row;
    goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return goodsCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopCarGoodsTableViewCell cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GoodsDetailsViewController *goodsVC = [[GoodsDetailsViewController alloc] init];
    NSDictionary *dict = _goodsArray[cell.tag];
    goodsVC.goodsID = dict[@"goodsID"];
    [self.navigationController pushViewController:goodsVC animated:YES];
    
}


#pragma mark -- ShopCarGoodsTableViewCellDelegate

- (void)selectBtnClick:(UITableViewCell *)cell
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSDictionary *dic = [[self.goodsArray objectAtIndex:indexPath.row] mutableCopy];
        
    
    if ([[dic objectForKey:@"isSelected"] boolValue]) {
        
        [dic setValue:@0 forKey:@"isSelected"];
        [self.goodsArray replaceObjectAtIndex:indexPath.row withObject:dic];
        
        _footer.isSelected = NO;
        
        [_footer.selectedAllBtn setImage:[UIImage imageNamed:@"i_checkbx_off.png"] forState:UIControlStateNormal];
        
        int count = 0;
        for (NSDictionary *dict in self.goodsArray) {
            
            if ([[dict objectForKey:@"isSelected"] boolValue] == NO) {
                
                count ++;
            }
        }
        if (count == self.goodsArray.count) {
            
            _footer.acountBtn.backgroundColor = [UIColor grayColor];
            _footer.acountBtn.userInteractionEnabled = NO;
        }
    }
    else
    {
        [dic setValue:@1 forKey:@"isSelected"];
        [self.goodsArray replaceObjectAtIndex:indexPath.row withObject:dic];
        
        int count = 0;
        for (dic in self.goodsArray) {
            
            if ([[dic objectForKey:@"isSelected"] boolValue] == YES) {
                
                count ++;
            }
        }
        if (count == self.goodsArray.count) {
            
             [_footer.selectedAllBtn setImage:[UIImage imageNamed:@"i_checkbx_on.png"] forState:UIControlStateNormal];
        }
        
        _footer.acountBtn.backgroundColor = GLOBAL_RedColor;
        _footer.acountBtn.userInteractionEnabled = YES;
           }
    
    
    
    [self totalPrice];

        [self loadDataWithView:self.view];
    //刷新当期cell
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)btnClick:(UITableViewCell *)cell andFlag:(NSInteger)flag
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSMutableDictionary *dic = [[self.goodsArray objectAtIndex:indexPath.row ] mutableCopy];
    
    switch (flag) {
        case 11:
        {
            if ([[dic objectForKey:@"goodsNum"] integerValue] > 1) {
            
                NSInteger num = [[dic objectForKey:@"goodsNum"] integerValue]  ;
                
                --num;
                
                [dic setValue:[NSString stringWithFormat:@"%ld",num] forKey:@"goodsNum"] ;
                [self.goodsArray replaceObjectAtIndex:indexPath.row withObject:dic];
            }
        }
            break;
        
        case 12:
        {
            NSInteger num = [[dic objectForKey:@"goodsNum"] integerValue]  ;
            
            ++num;
            
            [dic setValue:[NSNumber numberWithInteger:num]forKey:@"goodsNum"] ;
//            NSLog(@"magi %ld,%@",indexPath.row,_goodsArray);
            [_goodsArray replaceObjectAtIndex:indexPath.row withObject:dic];
        }
            break;
        default:
            break;
    }
    
    [self totalPrice];
    [self loadDataWithView:self.view];
    
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

- (void)goodsImgViewClick
{
    NSLog(@"goodsImgViewClick");
};

#pragma mark -- ShopCarFooterTableViewCellDelegate
- (void)selectedAllBtnClickWithIsSelected:(BOOL)isSelected
{
   
    
    
    if (isSelected == YES) {
        [_footer.selectedAllBtn setImage:[UIImage imageNamed:@"i_checkbx_off.png"] forState:UIControlStateNormal];
        
        goodsDetailInfo *info = [[goodsDetailInfo alloc] init];
        
        for (int i = 0; i < self.goodsArray.count; i ++) {
            
            info = self.goodsArray[i];
            info.isSelected = NO;
            
            [self.goodsArray replaceObjectAtIndex:i withObject:info];
        
        }
        _footer.isSelected = NO;
        
        _footer.acountBtn.backgroundColor = [UIColor grayColor];
        _footer.acountBtn.userInteractionEnabled = NO;
        [_tableView reloadData];
        
    }
    else
    {
        [_footer.selectedAllBtn setImage:[UIImage imageNamed:@"i_checkbx_on.png"] forState:UIControlStateNormal];
        
        goodsDetailInfo *info = [[goodsDetailInfo alloc] init];

        for (int i = 0; i < self.goodsArray.count; i ++) {
            
            info = self.goodsArray[i];
            info.isSelected = YES;
            
            [self.goodsArray replaceObjectAtIndex:i withObject:info];
        }
       
        _footer.isSelected = YES;
        _footer.acountBtn.userInteractionEnabled = YES;
        _footer.acountBtn.backgroundColor = GLOBAL_RedColor;
        [_tableView reloadData];
    }
    
    [self totalPrice];
    
    [self loadDataWithView:self.view];
//    NSLog(@"select%d",_footer.isSelected );
    
}

- (void)toAccountBtnClick
{
    ConfirmOrderViewController *orderVC = [[ConfirmOrderViewController alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in _goodsArray) {
        BOOL isSelected = [dict[@"isSelected"] boolValue];
        if (isSelected) {
            [array addObject:dict];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"buyArray"];
    [[NSUserDefaults standardUserDefaults] setObject: [NSString stringWithFormat:@"%0.0f",_allPrice]forKey:@"allPrice"];
    [self.navigationController pushViewController:orderVC animated:YES];
}



#pragma mark -- 
#pragma mark -- response event

- (void)totalPrice
{
    _allPrice =0.0;
    for (NSDictionary *dic in self.goodsArray) {
        
        if ([[dic objectForKey:@"isSelected"] boolValue]) {
            
            _allPrice = _allPrice + [[dic objectForKey:@"huiPrice"] integerValue] * [[dic objectForKey:@"goodsNum"] integerValue];
        }
        
    }
    
    [_footer.allPriceLabel setText:[NSString stringWithFormat:@"%.0f",_allPrice]];
}

- (UIView *)addFooterView
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, [GHStringManger stringBoundingRectWithSize:CGSizeMake(200, 21) font:FONT15 text:@"商品结算总金额："].width, 21)];
    nameLabel.font = FONT15;
    nameLabel.text = @"商品结算总金额：";
    
    [footer addSubview:nameLabel];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 11, 100, 21)];
    
    [self totalPrice];
    accountLabel.text = [NSString stringWithFormat:@"%.0f",_allPrice];
    
    accountLabel.textColor = GLOBAL_RedColor;
    
    accountLabel.font = FONT15;
    
    accountLabel.textAlignment = NSTextAlignmentLeft;
    
    [footer addSubview:accountLabel];
    return footer;
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


- (UITableView *)tableView
{
    if (_tableView == nil) {
        if (_isAddShopCar) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-[ShopCarFooterTableViewCell cellHeight])];
        }
        else
        {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49 -[ShopCarFooterTableViewCell cellHeight])];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    _tableView.tableFooterView = [self addFooterView];
    
    return _tableView;
}


- (ShopCarFooterTableViewCell *)footer
{
    if (_footer == nil) {
        _footer = [[[NSBundle mainBundle] loadNibNamed:@"ShopCarFooterTableViewCell" owner:self options:nil ] lastObject];
        if (_isAddShopCar ) {
            _footer.frame = CGRectMake(0, SCREEN_HEIGHT- [ShopCarFooterTableViewCell cellHeight], SCREEN_WIDTH, 49);
        }
        else
        {
           _footer.frame = CGRectMake(0, SCREEN_HEIGHT-49 -[ShopCarFooterTableViewCell cellHeight], SCREEN_WIDTH, [ShopCarFooterTableViewCell cellHeight]);
        }
        
        _footer.delegate = self;
    }
    
    return _footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)goodsArray
{
    if (_goodsArray == nil) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
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
