//
//  SDPhotoGroup.h
//  SDPhotoBrowser
//
//  Created by aier on 15-2-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^SDPhotoGroupBlock)(BOOL stata,CGFloat sdHeight);

@protocol SDPhotoGroupDelegate <NSObject>

- (CGFloat)getThePhotoGroupHeight;

@end


@interface SDPhotoGroup : UIView 

@property (nonatomic, strong) NSArray *photoItemArray;
@property(nonatomic,assign) id<SDPhotoGroupDelegate> delegate;

//@property(nonatomic,copy)SDPhotoGroupBlock sdPhotoGroupBlock;

//- (void)getHeigthWithSDPhotoGroupBlock:(SDPhotoGroupBlock)sdBlcok;
@end
