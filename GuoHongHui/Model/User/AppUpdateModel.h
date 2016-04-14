//
//  AppUpdateModel.h
//  GuoHongHui
//
//  Created by LuMig on 15/5/7.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdateBlock)(BOOL state, NSMutableDictionary *dataDic);

@interface AppUpdateModel : NSObject

@property(nonatomic,strong)NSMutableDictionary *dataDict;

- (void)getUpdateMessageWithUpdateBlock:(UpdateBlock)updateBlock;



@end
