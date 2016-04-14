//
//  ProjectProgressViewController.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/13.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "BaseViewController.h"

@interface ProjectProgressViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSNumber *projectId;
@end
