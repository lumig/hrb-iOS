//
//  CalendarViewController.m
//  Calendar
//
//  Created by 张凡 on 14-8-21.
//  Copyright (c) 2014年 张凡. All rights reserved.
//



#import "CalendarViewController.h"
//UI
#import "CalendarMonthCollectionViewLayout.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarDayCell.h"
//MODEL
#import "CalendarDayModel.h"
#import "FooterCollectionReusableView.h"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface CalendarViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate>
{

     NSTimer* timer;//定时器

}

@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation CalendarViewController

static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";

static NSString *FootCell = @"FootCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initData];
        [self initView];
    }
    return self;
}

- (void)viewDidLoad·
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initView{
    
    
    [self setTitle:@"选择日期"];
    
    CalendarMonthCollectionViewLayout *layout = [CalendarMonthCollectionViewLayout new];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height ) collectionViewLayout:layout]; //初始化网格视图大小
    
    [self.collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
    
    [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 120);
    
    //设置footer
    [self.collectionView registerClass:[FooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:FootCell];
    
//    self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    
    self.collectionView.contentSize = CGSizeMake(0, (self.collectionView.frame.size.height  ) * 12);
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = YES;
    
//    self.collectionView.showsVerticalScrollIndicator = NO;
    
//    self.pageControl = [[UIPageControl alloc] init];
//    self.pageControl.bounds = CGRectMake(0, 0, 20, 150);
//    _pageControl.center = CGPointMake(20, self.view.bounds.size.height * 0.5f);
//    _pageControl.numberOfPages = 12;
//    _pageControl.currentPageIndicatorTintColor = RGBACOLOR(215, 29, 25, 1);
//    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    _pageControl.currentPage = 0;
//    
//    [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
//    
//    [self.collectionView addSubview:self.pageControl];
    
}



-(void)initData{
    
    self.calendarMonth = [[NSMutableArray alloc] init];//每个月份的数组
    
}



#pragma mark - CollectionView代理方法

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.calendarMonth.count;
}


//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:section];
    return monthArray.count;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    
    return cell;
}

//- (void)turnPage
//{
//    NSInteger page = _pageControl.currentPage; // 获取当前的page
//    
//    //    [_scrollView setContentOffset:CGPointMake((_scrollView.frame.size.width)*(page), kWidth - 30) animated:NO];
//    
//    [_collectionView setContentOffset:CGPointMake((_collectionView.frame.size.height)*(page),0)]; // 触摸pagecontroller那个点点 往后翻一页 +1
//}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 120);
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];

        CalendarMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%lu年 %lu月",model.year,model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
        reusableview = monthHeader;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
            
        FooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FootCell forIndexPath:indexPath];
        
                footerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
         NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];
        
        
        [footerView.waitingNameLabel setText:[NSString stringWithFormat:@"%lu月待收益",model.month]];
        
        if (_isEveryMonthEarning) {
            if (indexPath.section == _calendarMonth.count - 1) {
                 [footerView.waitingMoneyLabel setText:[NSString stringWithFormat:@"%@",_dataArray[0]]];
                   footerView.waitingMoneyLabel.attributedText = [self attributedGlodString:[NSString stringWithFormat:@"%@元",_dataArray[0]] formString:@"元"];
            }
            else
            {
                [footerView.waitingMoneyLabel setText:[NSString stringWithFormat:@"0"]];
                footerView.waitingMoneyLabel.attributedText = [self attributedGlodString:[NSString stringWithFormat:@"0元"] formString:@"元"];
            }
        }
        else
        {
            if (indexPath.section <_dataArray.count) {
//                NSLog(@"indexpath.row %ld,%ld",model.month,indexPath.section);
                
                [footerView.waitingMoneyLabel setText:[NSString stringWithFormat:@"%@",_dataArray[indexPath.section]]];
                footerView.waitingMoneyLabel.attributedText = [self attributedGlodString:[NSString stringWithFormat:@"%@元",_dataArray[indexPath.section]] formString:@"元"];
            }
          
        }
        
        
        
        
        //进行判断
//        [footerView.havingNameLabel setText:[NSString stringWithFormat:@"%lu月已收益",model.month]];
//        footerView.havingMoneyLabel.attributedText = [self attributedGlodString:[NSString stringWithFormat:@"%.2f元",50200.10] formString:@"元"];
//        
        reusableview = footerView;
    }
    

    return reusableview;
    
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [month_Array objectAtIndex:indexPath.row];

    if (model.style == CellDayTypeFutur || model.style == CellDayTypeWeek ||model.style == CellDayTypeClick) {
       
        [self.Logic selectLogic:model];
        
        if (self.calendarblock) {
            
            self.calendarblock(model);//传递数组给上级
            
//            timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        }
        [self.collectionView reloadData];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}




//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 0; //section的高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) 
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//    
//    else
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//
//    }
//    
////    NSLog(@"magi%f",scrollView.contentOffset.y);
//}


//定时器方法
- (void)onTimer{
    
    [timer invalidate];//定时器无效
    
    timer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableAttributedString *)attributedGlodString:(NSString *)string formString:(NSString *)formString
{
    NSMutableAttributedString *comAttriStr = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSRange range = [string rangeOfString:formString];
    
    NSUInteger length = [string length] - range.location;
    
    [comAttriStr addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(215, 29, 25, 1) range:NSMakeRange(0, [string length] - length)];
    
    [comAttriStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"TrebuchetMS-Bold" size:14] range:NSMakeRange(0, [string length])];
    
    //    [comAttriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, length)];
    
    return comAttriStr;
}


@end
