//
//  EmptyCarView.h
//  iosApp
//
//  Created by admin on 15/2/10.
//  Copyright (c) 2015年 lifevc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EmptyCarViewDelegate <NSObject>
@optional
- (void)emptyViewDidClick;

@end

@interface EmptyCarView : UIView

@property(nonatomic,strong)UIImageView *imgView;

@property (assign,nonatomic)id<EmptyCarViewDelegate> delegate;

//- (IBAction)strollButtonClick:(id)sender;

@end
