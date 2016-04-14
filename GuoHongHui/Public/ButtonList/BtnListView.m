//
//  BtnListView.m
//  BtnListDemo
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 GUOHONGHUI. All rights reserved.
//



#import "BtnListView.h"
#import "ListButton.h"
//一行列个
#define eatchLineNum 4
//多少行
#define kNum 2
//btn总个数
#define kCount 11

#define btnTag 1000


#define eatchWidth(rect) (float)(rect.size.width )/eatchLineNum

#define lineBackColor [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1]

//#define lineBackColor [UIColor redColor]
@implementation BtnListView


- (id)initWithFrame:(CGRect)rect andImageArray:(NSArray *)imageArray andTitleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:rect];
    
    if (self) {
        
        
        int count = 0;
        for (int i = 0; i < kNum; i++) {
            
            
            for (int j = 0; j < eatchLineNum; j++) {
                ListButton *btn = [[ListButton alloc] init];
                
                //进行判断如果大于kCount,就不创建按钮
                if (i == kNum - 1 && j == eatchLineNum -1) {
                    break ;
                }
                
                btn.frame = CGRectMake(j * eatchWidth(rect), i * eatchWidth(rect) + 1, eatchWidth(rect), eatchWidth(rect));
                
                
                btn.tag = btnTag + count ;
                
                count++;
                if (count > imageArray.count) {
                    break ;
                }
                [btn setImage:[UIImage imageNamed:imageArray[btn.tag - 1000]] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:imageArray[btn.tag - 1000]] forState:UIControlStateHighlighted];
                
                [btn setTitle:titleArray[btn.tag - 1000] forState:UIControlStateNormal];
                [btn setTitle:titleArray[btn.tag - 1000] forState:UIControlStateHighlighted];
                
                //                    NSLog(@"imageArray%@",self.btnImgArray);
                //                    NSLog(@"btn tag %ld",btn.tag);
                
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                //                NSLog(@"btnframe%@",NSStringFromCGRect(btn.frame));
                
                [self addSubview:btn];
                
                UIImageView *columnLineView = [[UIImageView alloc] init];
                columnLineView.frame = CGRectMake((j+1)*eatchWidth(rect), 0, 1, kNum * eatchWidth(rect));
                columnLineView.backgroundColor = lineBackColor;
                
//                NSLog(@"column%@,%f",NSStringFromCGRect(columnLineView.frame),columnLineView.frame.origin.x);
                
                [self addSubview:columnLineView];
                
                UIImageView *lineView = [[UIImageView alloc] init];
                
                if (i == 0) {
                    lineView.frame = CGRectMake(0, 0 , [UIScreen mainScreen].bounds.size.width, 1);
                }
               
                else                 {
                    lineView.frame = CGRectMake(0, eatchWidth(rect) * i, [UIScreen mainScreen].bounds.size.width, 1);
                    
                }
                
                if (i == kNum - 1) {
                    UIImageView *lastLineView = [[UIImageView alloc] init];
                    lastLineView.frame = CGRectMake(0, eatchWidth(rect) * kNum , [UIScreen mainScreen].bounds.size.width, 1);
                    lastLineView.backgroundColor = lineBackColor;
                    [self addSubview:lastLineView];
                }
                
                lineView.backgroundColor = lineBackColor;
                
                [self addSubview:lineView];
                
            }
            
        }

        
    }
    
    return self;
    
}


//- (void)setBtnArray:(NSMutableArray *)btnArray
//{
//    _btnArray = btnArray;
//
//}


- (void)btnClick:(UIButton *)btn
{

    if ([self.delegate respondsToSelector:@selector(btnClickWith:)]) {
        
        [self.delegate btnClickWith:btn];
    }
    
    
    
}



@end
