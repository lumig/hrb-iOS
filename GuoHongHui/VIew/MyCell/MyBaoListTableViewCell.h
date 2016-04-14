//
//  MyBaoListTableViewCell.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/19.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myBaoInfo.h"


@interface MyBaoListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lefImgView;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;


@property (weak, nonatomic) IBOutlet UIImageView *imgView;



- (void)fillCellWithMyBaoInfo:(myBaoInfo *)info;

@end
